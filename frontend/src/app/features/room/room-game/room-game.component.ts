import { Component, ElementRef, HostListener, OnDestroy, OnInit, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { interval, Subject } from 'rxjs';
import { exhaustMap, startWith, takeUntil } from 'rxjs/operators';
import { RoomService } from '../../../core/services/room.service';
import { RoomWebSocketService } from '../../../core/services/room-websocket.service';
import { ChatMessage, RoomState } from '../../../core/models/room.model';
import { SpeechService } from '../../../core/services/speech.service';
import { AuthService } from '../../../core/services/auth.service';
import { AudioService } from '../../../core/services/audio.service';

interface AnswerRecord {
  word: string;
  meaning: string;
  partOfSpeech?: string;
  mode: 'CHOICE' | 'TYPE';
  correct: boolean;
  myChoiceText?: string;
  correctText: string;
}

@Component({
  selector: 'app-room-game',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './room-game.component.html',
  styleUrls: ['./room-game.component.scss']
})
export class RoomGameComponent implements OnInit, OnDestroy {
  code = '';
  state: RoomState | null = null;
  loading = signal(true);
  error = signal('');
  startingGame = signal(false);

  // Typing mode state
  typedAnswer = '';
  lastSubmittedAnswer = '';
  typeCorrect = signal<boolean | null>(null);
  typingLocked = signal(false);
  private lastQuestionIndex = -1;
  @ViewChild('typeInput') typeInput?: ElementRef<HTMLInputElement>;

  // Answer history (recorded during SHOWING_RESULT for done screen)
  answerHistory: AnswerRecord[] = [];
  showHistory = signal(false);
  private lastRecordedIndex = -1;

  // Chat
  chatMessages: ChatMessage[] = [];
  chatInput = '';
  showChat = signal(false);
  unreadCount = signal(0);
  @ViewChild('chatBody') chatBody?: ElementRef<HTMLDivElement>;

  // Reactions
  readonly REACTIONS = ['❤️', '😂', '🔥', '👏', '😮', '💀'];
  floatingReactions: { id: number; emoji: string; username: string; x: number }[] = [];
  private reactionCounter = 0;

  private destroy$ = new Subject<void>();

  private prevStatus = '';
  private prevCountdown = -1;
  private prevTimeLeft = -1;
  private resultSoundPlayed = false;

  // Smooth local countdown, resynced from the server on every successful poll instead of
  // being redrawn only when a poll happens to land — so a slow/delayed poll response
  // doesn't make the displayed timer freeze then jump.
  displayTimeLeft = signal(0);
  private timeLeftSyncedAt = 0;
  private timeLeftSyncedValue = 0;

  constructor(
    private route: ActivatedRoute,
    private roomService: RoomService,
    private wsService: RoomWebSocketService,
    readonly speech: SpeechService,
    readonly authService: AuthService,
    private audio: AudioService
  ) {}

  @HostListener('window:keydown', ['$event'])
  onKey(e: KeyboardEvent): void {
    if (!this.state || this.state.status !== 'ACTIVE') return;
    if (this.state.myAnswer !== null) return;
    const isTyping = e.target instanceof HTMLInputElement;

    if (this.state.currentQuestionMode === 'CHOICE') {
      if (['1','2','3','4'].includes(e.key)) {
        e.preventDefault();
        this.selectOption(+e.key - 1);
      }
    } else {
      // typing mode — Enter submits
      if (e.key === 'Enter' && !isTyping) {
        e.preventDefault();
        this.submitTyped();
      }
    }
  }

  ngOnInit(): void {
    this.code = this.route.snapshot.paramMap.get('code')!;
    const isSpectator = this.route.snapshot.queryParamMap.get('spectator') === '1';
    if (isSpectator) {
      // Already registered as spectator in lobby — skip joinRoom
      this.startPolling();
      this.connectWs();
    } else {
      this.roomService.joinRoom(this.code).subscribe({
        next: () => {
          this.startPolling();
          this.connectWs();
        },
        error: err => {
          this.error.set(err?.error?.message || 'Không tìm thấy phòng.');
          this.loading.set(false);
        }
      });
    }
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
    this.wsService.disconnect();
  }

  private connectWs(): void {
    this.wsService.connect(this.code).pipe(takeUntil(this.destroy$)).subscribe(event => {
      if (event.type === 'CHAT') {
        if (event.userId === this.myUserId) return; // already shown locally
        this.chatMessages.push({
          userId: event.userId,
          username: event.username,
          text: event.text!,
          timestamp: event.timestamp,
          spectator: event.spectator
        });
        if (!this.showChat()) this.unreadCount.update(n => n + 1);
        setTimeout(() => {
          if (this.chatBody) {
            this.chatBody.nativeElement.scrollTop = this.chatBody.nativeElement.scrollHeight;
          }
        }, 50);
      } else if (event.type === 'REACT') {
        // Skip own reactions — already shown immediately on click
        if (event.userId !== this.myUserId) {
          this.addFloatingReaction(event.emoji!, event.username);
        }
      }
    });
  }

  private addFloatingReaction(emoji: string, username: string): void {
    const id = this.reactionCounter++;
    const x = 5 + Math.random() * 70;
    this.floatingReactions.push({ id, emoji, username, x });
    setTimeout(() => {
      this.floatingReactions = this.floatingReactions.filter(r => r.id !== id);
    }, 2500);
  }

  toggleChat(): void {
    this.showChat.update(v => !v);
    if (this.showChat()) {
      this.unreadCount.set(0);
      setTimeout(() => {
        if (this.chatBody) {
          this.chatBody.nativeElement.scrollTop = this.chatBody.nativeElement.scrollHeight;
        }
      }, 50);
    }
  }

  sendChat(): void {
    const text = this.chatInput.trim();
    if (!text) return;
    const me = this.authService.currentUser();
    this.chatMessages.push({
      userId: this.myUserId,
      username: me?.displayName || me?.username || 'Bạn',
      text,
      timestamp: Date.now(),
      spectator: this.state?.spectator ?? false
    });
    this.wsService.sendChat(text);
    this.chatInput = '';
    setTimeout(() => {
      if (this.chatBody) this.chatBody.nativeElement.scrollTop = this.chatBody.nativeElement.scrollHeight;
    }, 50);
  }

  sendReact(emoji: string): void {
    const me = this.authService.currentUser();
    const myName = me?.displayName || me?.username || 'Bạn';
    this.addFloatingReaction(emoji, myName);
    this.wsService.sendReact(emoji);
  }

  private startPolling(): void {
    this.loading.set(false);
    // exhaustMap (not switchMap): if a poll response is slow (e.g. backend under load),
    // don't cancel it and fire another — that pile-up of cancelled requests is exactly
    // what made the timer freeze then jump on a slow backend. exhaustMap just skips
    // ticks until the in-flight request resolves.
    interval(1000).pipe(
      startWith(0),
      exhaustMap(() => this.roomService.getState(this.code)),
      takeUntil(this.destroy$)
    ).subscribe({
      next: state => {
        // Resync the local smooth countdown to the server's authoritative value.
        this.timeLeftSyncedAt = Date.now();
        this.timeLeftSyncedValue = state.timeLeft;
        this.displayTimeLeft.set(state.timeLeft);

        // Record answer history when result is shown (once per question)
        if (state.status === 'SHOWING_RESULT' && state.questionIndex !== this.lastRecordedIndex && state.currentQuestion) {
          this.lastRecordedIndex = state.questionIndex;
          const q = state.currentQuestion;
          const correct = state.myAnswer !== null && state.myAnswer >= 0 && state.myAnswer === state.correctIndex;
          this.answerHistory.push({
            word: q.word,
            meaning: state.correctMeaning ?? '',
            partOfSpeech: q.partOfSpeech,
            mode: state.currentQuestionMode,
            correct,
            myChoiceText: state.currentQuestionMode === 'CHOICE' && state.myAnswer !== null && state.myAnswer >= 0
              ? q.options[state.myAnswer] : undefined,
            correctText: state.currentQuestionMode === 'CHOICE'
              ? q.options[state.correctIndex ?? 0]
              : q.word
          });
        }
        // Reset typing state when question changes
        if (state.questionIndex !== this.lastQuestionIndex) {
          this.lastQuestionIndex = state.questionIndex;
          this.typedAnswer = '';
          this.lastSubmittedAnswer = '';
          this.typeCorrect.set(null);
          this.typingLocked.set(false);
          // Don't steal focus from the chat box (or any other input) the user is
          // currently typing in — otherwise their next Enter submits the quiz
          // answer instead of sending their chat message.
          setTimeout(() => {
            const active = document.activeElement;
            const typingElsewhere = active instanceof HTMLInputElement && active !== this.typeInput?.nativeElement;
            if (!typingElsewhere) {
              this.typeInput?.nativeElement?.focus();
            }
          }, 100);
        }

        // --- Sound triggers ---
        const status = state.status;

        // Countdown ticks (3-2-1)
        if (status === 'COUNTDOWN' && state.countdownLeft !== this.prevCountdown) {
          this.prevCountdown = state.countdownLeft;
          if (state.countdownLeft === 1) this.audio.tickFinal();
          else if (state.countdownLeft > 0) this.audio.tick();
        }

        // New question revealed
        if (status === 'ACTIVE' && this.prevStatus !== 'ACTIVE') {
          if (this.prevStatus === 'COUNTDOWN' && state.questionIndex === 0) {
            this.audio.gameStart();
          } else {
            this.audio.questionReveal();
          }
          this.resultSoundPlayed = false;
        }

        // Timer ticking last 5s
        if (status === 'ACTIVE' && state.timeLeft <= 5 && state.timeLeft > 0
            && state.timeLeft !== this.prevTimeLeft) {
          this.audio.timerTick();
        }

        // Result sound (correct / wrong) — once per question
        if (status === 'SHOWING_RESULT' && !this.resultSoundPlayed && state.myAnswer !== null) {
          this.resultSoundPlayed = true;
          const correct = state.myAnswer >= 0 && state.myAnswer === state.correctIndex;
          if (!state.spectator) correct ? this.audio.correct() : this.audio.wrong();
        }

        // Game done
        if (status === 'DONE' && this.prevStatus !== 'DONE') {
          this.audio.victory();
        }

        this.prevStatus = status;
        this.prevTimeLeft = state.timeLeft;
        // --- End sounds ---

        this.state = state;
      },
      error: () => {}
    });

    // Local 1s ticker for the displayed countdown, independent of poll arrival timing —
    // resynced to the server's value on every poll above, so drift never accumulates.
    interval(1000).pipe(takeUntil(this.destroy$)).subscribe(() => {
      if (this.state?.status !== 'ACTIVE') return;
      const elapsedSec = Math.floor((Date.now() - this.timeLeftSyncedAt) / 1000);
      this.displayTimeLeft.set(Math.max(0, this.timeLeftSyncedValue - elapsedSec));
    });
  }

  get choiceWordLetters(): string[] {
    return this.state?.currentQuestion?.word.split('') ?? [];
  }

  get meaningLetters(): string[] {
    return this.state?.correctMeaning?.split('') ?? [];
  }

  get wordHintBoxes(): { char: string; blank: boolean }[] {
    const word = this.state?.currentQuestion?.word;
    if (!word) return [];
    // Backend already masks the word (first letter + underscores), use as-is
    return word.split('').map(ch => ({
      char: ch,
      blank: ch === '_'
    }));
  }

  get myUserId(): number {
    return this.authService.currentUser()?.userId ?? 0;
  }

  get isHost(): boolean {
    return this.state?.hostId === this.myUserId;
  }

  trackByIndex(index: number): number {
    return index;
  }

  get timerPercent(): number {
    if (!this.state) return 100;
    return (this.displayTimeLeft() / 15) * 100;
  }

  get timerColor(): string {
    const pct = this.timerPercent;
    if (pct > 60) return '#22c55e';
    if (pct > 30) return '#f59e0b';
    return '#ef4444';
  }

  kickPlayer(targetId: number): void {
    this.roomService.kickPlayer(this.code, targetId).subscribe({
      error: err => { this.error.set(err?.error?.message || 'Không thể kick người chơi.'); }
    });
  }

  setPlayerAsSpectator(targetId: number): void {
    this.roomService.setSpectator(this.code, targetId).subscribe({
      error: err => { this.error.set(err?.error?.message || 'Không thể chuyển sang khán giả.'); }
    });
  }

  setSpectatorAsPlayer(targetId: number): void {
    this.roomService.setPlayer(this.code, targetId).subscribe({
      error: err => { this.error.set(err?.error?.message || 'Không thể chuyển sang người chơi.'); }
    });
  }

  becomeSpectator(): void {
    this.roomService.spectateRoom(this.code).subscribe({
      next: () => {},
      error: err => { this.error.set(err?.error?.message || 'Không thể chuyển sang khán giả.'); }
    });
  }

  becomePlayer(): void {
    this.roomService.joinRoom(this.code).subscribe({
      next: () => {},
      error: err => { this.error.set(err?.error?.message || 'Không thể chuyển sang người chơi.'); }
    });
  }

  startGame(): void {
    this.startingGame.set(true);
    this.roomService.startGame(this.code).subscribe({
      next: () => this.startingGame.set(false),
      error: () => this.startingGame.set(false)
    });
  }

  selectOption(idx: number): void {
    if (!this.state || this.state.status !== 'ACTIVE') return;
    if (this.state.myAnswer !== null) return;
    this.roomService.submitAnswer(this.code, idx).subscribe();
    this.state = { ...this.state, myAnswer: idx };
  }

  submitTyped(): void {
    if (!this.state || this.state.status !== 'ACTIVE') return;
    if (this.state.myAnswer !== null || this.typingLocked()) return;
    if (!this.typedAnswer.trim()) return;

    this.typingLocked.set(true);
    const word = this.typedAnswer.trim();
    this.lastSubmittedAnswer = word;
    this.roomService.submitTypedAnswer(this.code, word).subscribe({
      next: res => {
        this.typeCorrect.set(res.correct ? true : false);
        this.state = { ...this.state!, myAnswer: res.correct ? 0 : -1 };
      },
      error: () => this.typingLocked.set(false)
    });
  }

  onTypedChange(): void {
    if (this.typeCorrect() === false) {
      this.typeCorrect.set(null);
    }
  }

  getOptionClass(idx: number): string {
    if (!this.state) return '';
    const { status, correctIndex, myAnswer } = this.state;
    if (status === 'ACTIVE') {
      return myAnswer === idx ? 'selected-answer' : '';
    }
    if (status === 'SHOWING_RESULT') {
      if (idx === correctIndex) return 'correct';
      if (myAnswer === idx && idx !== correctIndex) return 'wrong';
      return 'dimmed';
    }
    return '';
  }

  get correctCount(): number {
    return this.answerHistory.filter(r => r.correct).length;
  }

  copyCode(): void {
    navigator.clipboard.writeText(this.code);
  }
}

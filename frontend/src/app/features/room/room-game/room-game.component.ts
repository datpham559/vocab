import { Component, ElementRef, HostListener, OnDestroy, OnInit, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { interval, Subject } from 'rxjs';
import { startWith, switchMap, takeUntil } from 'rxjs/operators';
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
      username: me?.username ?? 'Bạn',
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
    const myName = this.authService.currentUser()?.username ?? 'Bạn';
    this.addFloatingReaction(emoji, myName);
    this.wsService.sendReact(emoji);
  }

  private startPolling(): void {
    this.loading.set(false);
    interval(1000).pipe(
      startWith(0),
      switchMap(() => this.roomService.getState(this.code)),
      takeUntil(this.destroy$)
    ).subscribe({
      next: state => {
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
          this.typeCorrect.set(null);
          this.typingLocked.set(false);
          setTimeout(() => this.typeInput?.nativeElement?.focus(), 100);
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

  get timerPercent(): number {
    if (!this.state) return 100;
    return (this.state.timeLeft / 15) * 100;
  }

  get timerColor(): string {
    const pct = this.timerPercent;
    if (pct > 60) return '#22c55e';
    if (pct > 30) return '#f59e0b';
    return '#ef4444';
  }

  becomeSpectator(): void {
    this.roomService.spectateRoom(this.code).subscribe({
      next: () => {},
      error: err => { this.error.set(err?.error?.message || 'Không thể chuyển sang khán giả.'); }
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

import { Component, ElementRef, HostListener, OnDestroy, OnInit, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { interval, Subject } from 'rxjs';
import { startWith, switchMap, takeUntil } from 'rxjs/operators';
import { RoomService } from '../../../core/services/room.service';
import { RoomState } from '../../../core/models/room.model';
import { SpeechService } from '../../../core/services/speech.service';
import { AuthService } from '../../../core/services/auth.service';

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

  private destroy$ = new Subject<void>();

  constructor(
    private route: ActivatedRoute,
    private roomService: RoomService,
    readonly speech: SpeechService,
    readonly authService: AuthService
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
    this.roomService.joinRoom(this.code).subscribe({
      next: () => this.startPolling(),
      error: err => {
        this.error.set(err?.error?.message || 'Không tìm thấy phòng.');
        this.loading.set(false);
      }
    });
  }

  ngOnDestroy(): void {
    this.destroy$.next();
    this.destroy$.complete();
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
          const correct = state.currentQuestionMode === 'TYPE'
            ? state.myAnswer === 0
            : state.myAnswer === state.correctIndex;
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
        this.state = state;
      },
      error: () => {}
    });
  }

  get choiceWordLetters(): string[] {
    return this.state?.currentQuestion?.word.split('') ?? [];
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

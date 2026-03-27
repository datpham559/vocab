import { Component, HostListener, OnDestroy, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ActivatedRoute, Router, RouterLink } from '@angular/router';
import { interval, Subject, Subscription } from 'rxjs';
import { startWith, switchMap, takeUntil } from 'rxjs/operators';
import { RoomService } from '../../../core/services/room.service';
import { RoomState } from '../../../core/models/room.model';
import { SpeechService } from '../../../core/services/speech.service';
import { AuthService } from '../../../core/services/auth.service';

@Component({
  selector: 'app-room-game',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './room-game.component.html',
  styleUrls: ['./room-game.component.scss']
})
export class RoomGameComponent implements OnInit, OnDestroy {
  code = '';
  state: RoomState | null = null;
  loading = signal(true);
  error = signal('');
  startingGame = signal(false);

  private destroy$ = new Subject<void>();
  private pollSub?: Subscription;

  constructor(
    private route: ActivatedRoute,
    private router: Router,
    private roomService: RoomService,
    readonly speech: SpeechService,
    readonly authService: AuthService
  ) {}

  @HostListener('window:keydown', ['$event'])
  onKey(e: KeyboardEvent): void {
    if (!this.state || this.state.status !== 'ACTIVE') return;
    if (this.state.myAnswer !== null) return;
    if (['1','2','3','4'].includes(e.key)) {
      e.preventDefault();
      this.selectOption(+e.key - 1);
    }
  }

  ngOnInit(): void {
    this.code = this.route.snapshot.paramMap.get('code')!;
    // Auto-join (idempotent)
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
    this.pollSub = interval(1000).pipe(
      startWith(0),
      switchMap(() => this.roomService.getState(this.code)),
      takeUntil(this.destroy$)
    ).subscribe({
      next: state => { this.state = state; },
      error: () => {}
    });
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
    // Optimistic update
    this.state = { ...this.state, myAnswer: idx };
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

  getRank(userId: number): number {
    if (!this.state) return 0;
    return this.state.participants.findIndex(p => p.userId === userId) + 1;
  }

  copyCode(): void {
    navigator.clipboard.writeText(this.code);
  }
}

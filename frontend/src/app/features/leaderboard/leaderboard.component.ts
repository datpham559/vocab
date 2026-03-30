import { Component, OnInit, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LeaderboardService, LeaderboardEntry } from '../../core/services/leaderboard.service';
import { AuthService } from '../../core/services/auth.service';

type SortMode = 'streak' | 'words';

@Component({
  selector: 'app-leaderboard',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './leaderboard.component.html',
  styleUrls: ['./leaderboard.component.scss']
})
export class LeaderboardComponent implements OnInit {
  private service = inject(LeaderboardService);
  authService = inject(AuthService);

  mode = signal<SortMode>('streak');
  entries = signal<LeaderboardEntry[]>([]);
  loading = signal(true);
  error = signal('');

  ngOnInit(): void {
    this.load('streak');
  }

  switchMode(m: SortMode): void {
    if (this.mode() === m) return;
    this.mode.set(m);
    this.load(m);
  }

  private load(m: SortMode): void {
    this.loading.set(true);
    this.error.set('');
    const req = m === 'streak' ? this.service.getByStreak() : this.service.getByWords();
    req.subscribe({
      next: (data) => { this.entries.set(data); this.loading.set(false); },
      error: () => { this.error.set('Không thể tải bảng xếp hạng'); this.loading.set(false); }
    });
  }

  isMe(entry: LeaderboardEntry): boolean {
    return entry.userId === this.authService.currentUser()?.userId;
  }

  getInitials(name: string): string {
    return name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2);
  }

  rankClass(rank: number): string {
    if (rank === 1) return 'gold';
    if (rank === 2) return 'silver';
    if (rank === 3) return 'bronze';
    return '';
  }

  rankEmoji(rank: number): string {
    if (rank === 1) return '🥇';
    if (rank === 2) return '🥈';
    if (rank === 3) return '🥉';
    return String(rank);
  }
}

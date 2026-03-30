import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { ProgressService } from '../../core/services/progress.service';
import { SpeechService } from '../../core/services/speech.service';
import { UserWordProgress } from '../../core/models/word.model';

@Component({
  selector: 'app-favorites',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './favorites.component.html',
  styleUrls: ['./favorites.component.scss']
})
export class FavoritesComponent implements OnInit {
  bookmarks = signal<UserWordProgress[]>([]);
  loading = signal(true);
  expandedId: number | null = null;

  constructor(
    private progressService: ProgressService,
    readonly speech: SpeechService
  ) {}

  ngOnInit(): void {
    this.load();
  }

  load(): void {
    this.loading.set(true);
    this.progressService.getBookmarks().subscribe({
      next: bms => {
        this.bookmarks.set(bms);
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  toggleExpand(id: number): void {
    this.expandedId = this.expandedId === id ? null : id;
  }

  removeBookmark(wordId: number, event: Event): void {
    event.stopPropagation();
    this.progressService.toggleBookmark(wordId).subscribe(res => {
      if (!res.bookmarked) {
        this.bookmarks.set(this.bookmarks().filter(b => b.wordId !== wordId));
      }
    });
  }

  getStatusLabel(status: string): string {
    const labels: Record<string, string> = { NEW: 'Mới', LEARNING: 'Đang học', REVIEW: 'Ôn tập', MASTERED: 'Thành thạo' };
    return labels[status] || status;
  }

  getDifficultyLabel(d: string): string {
    const labels: Record<string, string> = { BEGINNER: 'Cơ bản', INTERMEDIATE: 'Trung cấp', ADVANCED: 'Nâng cao' };
    return labels[d] || d;
  }
}

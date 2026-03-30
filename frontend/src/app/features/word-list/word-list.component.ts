import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { WordService } from '../../core/services/word.service';
import { ProgressService } from '../../core/services/progress.service';
import { SpeechService } from '../../core/services/speech.service';
import { Word, WordDifficulty, UserWordProgress, ProgressStatus } from '../../core/models/word.model';

const CATEGORY_LABELS: Record<string, string> = {
  'Achievement': 'Thành tích', 'Actions': 'Hành động', 'Animals': 'Động vật',
  'Body': 'Cơ thể', 'Business': 'Kinh doanh', 'Character': 'Tính cách',
  'Clothing': 'Quần áo', 'Communication': 'Giao tiếp', 'Culture': 'Văn hóa',
  'Descriptive': 'Mô tả', 'Education': 'Giáo dục', 'Emotions': 'Cảm xúc',
  'Entertainment': 'Giải trí', 'Food': 'Thực phẩm', 'General': 'Chung',
  'Health': 'Sức khỏe', 'Home': 'Nhà cửa', 'Language': 'Ngôn ngữ',
  'Nature': 'Thiên nhiên', 'People': 'Con người', 'Places': 'Địa điểm',
  'Politics': 'Chính trị', 'Shopping': 'Mua sắm', 'Social': 'Xã hội',
  'Technology': 'Công nghệ', 'Thinking': 'Tư duy', 'Time': 'Thời gian',
  'Transport': 'Giao thông', 'Travel': 'Du lịch', 'Work': 'Công việc',
};

@Component({
  selector: 'app-word-list',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './word-list.component.html',
  styleUrls: ['./word-list.component.scss']
})
export class WordListComponent implements OnInit {
  words = signal<Word[]>([]);
  progress = signal<Map<number, ProgressStatus>>(new Map());
  bookmarked = signal<Set<number>>(new Set());
  loading = signal(true);
  totalPages = signal(0);
  currentPage = signal(0);
  totalElements = signal(0);

  searchTerm = '';
  selectedDifficulty: WordDifficulty | '' = '';
  selectedLetter = '';
  selectedCategory = '';
  expandedWordId: number | null = null;
  pageSize = 20;
  readonly pageSizeOptions = [10, 20, 50, 100];
  readonly alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');
  stats = signal<{ total: number; BEGINNER: number; INTERMEDIATE: number; ADVANCED: number } | null>(null);

  constructor(
    private wordService: WordService,
    private progressService: ProgressService,
    private route: ActivatedRoute,
    readonly speech: SpeechService
  ) {}

  get categoryLabel(): string {
    return this.selectedCategory ? (CATEGORY_LABELS[this.selectedCategory] ?? this.selectedCategory) : '';
  }

  ngOnInit(): void {
    this.selectedCategory = this.route.snapshot.queryParamMap.get('category') ?? '';
    this.load();
    this.wordService.getStats().subscribe(s => this.stats.set(s));
    this.progressService.getMyProgress().subscribe(progresses => {
      const map = new Map<number, ProgressStatus>();
      progresses.forEach(p => map.set(p.wordId, p.status));
      this.progress.set(map);
    });
    this.progressService.getBookmarks().subscribe(bms => {
      this.bookmarked.set(new Set(bms.map(b => b.wordId)));
    });
  }

  onPageSizeChange(): void {
    this.currentPage.set(0);
    this.load();
  }

  setLetter(letter: string): void {
    this.selectedLetter = letter;
    this.searchTerm = ''; // letter filter và search xung đột nhau
    this.currentPage.set(0);
    this.load();
  }

  load(): void {
    this.loading.set(true);
    this.wordService.getWords(
      this.currentPage(),
      this.pageSize,
      this.selectedDifficulty || undefined,
      this.selectedCategory || undefined,
      this.searchTerm || undefined,
      this.selectedLetter || undefined
    ).subscribe({
      next: page => {
        this.words.set(page.content);
        this.totalPages.set(page.totalPages);
        this.totalElements.set(page.totalElements);
        this.loading.set(false);
      },
      error: () => this.loading.set(false)
    });
  }

  search(): void {
    this.selectedLetter = ''; // search và letter filter xung đột nhau
    this.currentPage.set(0);
    this.load();
  }

  setDifficulty(d: WordDifficulty | ''): void {
    this.selectedDifficulty = d;
    this.currentPage.set(0);
    this.load();
  }

  // Xóa search/letter/difficulty nhưng GIỮ category
  clearFilters(): void {
    this.searchTerm = '';
    this.selectedDifficulty = '';
    this.selectedLetter = '';
    this.currentPage.set(0);
    this.load();
  }

  // Xóa tất cả kể cả category (dùng cho nút "Xem tất cả")
  clearAll(): void {
    this.searchTerm = '';
    this.selectedDifficulty = '';
    this.selectedLetter = '';
    this.selectedCategory = '';
    this.currentPage.set(0);
    this.load();
  }

  setPage(page: number): void {
    if (page < 0 || page >= this.totalPages()) return;
    this.currentPage.set(page);
    this.load();
  }

  filterByWord(word: string, event: Event): void {
    event.stopPropagation();
    this.searchTerm = word;
    this.selectedDifficulty = '';
    this.selectedLetter = '';
    this.currentPage.set(0);
    this.load();
  }

  toggleExpand(id: number): void {
    this.expandedWordId = this.expandedWordId === id ? null : id;
  }

  getStatus(wordId: number): ProgressStatus | null {
    return this.progress().get(wordId) || null;
  }

  getDifficultyClass(d: WordDifficulty): string {
    return `badge-${d.toLowerCase()}`;
  }

  getStatusClass(s: ProgressStatus | null): string {
    if (!s) return '';
    return `badge-${s.toLowerCase()}`;
  }

  isBookmarked(wordId: number): boolean {
    return this.bookmarked().has(wordId);
  }

  toggleBookmark(wordId: number, event: Event): void {
    event.stopPropagation();
    this.progressService.toggleBookmark(wordId).subscribe(res => {
      const set = new Set(this.bookmarked());
      if (res.bookmarked) set.add(wordId); else set.delete(wordId);
      this.bookmarked.set(set);
    });
  }

  getStatusLabel(s: ProgressStatus | null): string {
    const labels: Record<string, string> = { NEW: 'Mới', LEARNING: 'Đang học', REVIEW: 'Ôn tập', MASTERED: 'Thành thạo' };
    return s ? (labels[s] || s) : 'Chưa học';
  }

  get pages(): number[] {
    const total = this.totalPages();
    const current = this.currentPage();
    const delta = 2;
    const pages: number[] = [];

    const rangeStart = Math.max(0, current - delta);
    const rangeEnd = Math.min(total - 1, current + delta);

    if (rangeStart > 0) {
      pages.push(0);
      if (rangeStart > 1) pages.push(-1); // ellipsis
    }

    for (let i = rangeStart; i <= rangeEnd; i++) {
      pages.push(i);
    }

    if (rangeEnd < total - 1) {
      if (rangeEnd < total - 2) pages.push(-1); // ellipsis
      pages.push(total - 1);
    }

    return pages;
  }
}

import { Component, ElementRef, HostListener, OnInit, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { StudyService } from '../../../core/services/study.service';
import { ProgressService } from '../../../core/services/progress.service';
import { SpeechService } from '../../../core/services/speech.service';
import { KeyboardShortcutService } from '../../../core/services/keyboard-shortcut.service';
import { Word } from '../../../core/models/word.model';
import { QuizQuestion } from '../../../core/models/quiz.model';

type Phase = 'select' | 'flashcard' | 'quiz' | 'done';
type QuizMode = 'choice' | 'typing';
type TypeResult = 'correct' | 'close' | 'wrong' | null;

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
  selector: 'app-study-session',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './study-session.component.html',
  styleUrls: ['./study-session.component.scss']
})
export class StudySessionComponent implements OnInit {
  phase = signal<Phase>('select');
  loading = signal(false);

  // Category / mode
  activeCategory: string | null = null;
  bookmarksMode = false;
  get activeCategoryLabel(): string {
    if (this.bookmarksMode) return 'Từ yêu thích';
    return this.activeCategory ? (CATEGORY_LABELS[this.activeCategory] ?? this.activeCategory) : '';
  }

  // Select phase
  selectedCount = 20;
  countOptions = [10, 20, 50, 100, 200];

  // Flashcard phase
  words = signal<Word[]>([]);
  cardIndex = signal(0);
  flipped = signal(false);
  flashResults: { word: Word; correct: boolean }[] = [];

  // Quiz phase
  questions = signal<QuizQuestion[]>([]);
  quizIndex = signal(0);
  selectedOption = signal<number | null>(null);
  answered = signal(false);
  quizResults: { question: QuizQuestion; selectedIndex: number; correct: boolean }[] = [];
  score = signal(0);

  // Per-question mode
  questionModes: QuizMode[] = [];
  get currentMode(): QuizMode { return this.questionModes[this.quizIndex()] ?? 'choice'; }

  // Typing mode
  typedAnswer = '';
  typeResult = signal<TypeResult>(null);
  @ViewChild('typeInput') typeInput?: ElementRef<HTMLInputElement>;

  get wordHintBoxes(): { char: string; blank: boolean }[] {
    const q = this.currentQuestion;
    if (!q) return [];
    return q.word.split('').map((ch, i) => ({
      char: (i === 0 || ch === ' ' || ch === '-') ? ch : '_',
      blank: i !== 0 && ch !== ' ' && ch !== '-'
    }));
  }

  constructor(
    private studyService: StudyService,
    private progressService: ProgressService,
    private route: ActivatedRoute,
    readonly speech: SpeechService,
    readonly kbd: KeyboardShortcutService
  ) {}

  @HostListener('document:keydown', ['$event'])
  onKey(e: KeyboardEvent): void {
    // Don't trigger when typing in an input
    const tag = (e.target as HTMLElement).tagName;
    const inInput = tag === 'INPUT' || tag === 'TEXTAREA';

    // --- Flashcard phase ---
    if (this.phase() === 'flashcard' && this.currentWord) {
      if (!this.flipped()) {
        // Flip on Space / Enter
        if ((e.key === ' ' || e.key === 'Enter') && !inInput) {
          e.preventDefault();
          this.flip();
          this.speech.speak(this.currentWord.word);
        }
      } else {
        // Answer buttons visible
        if (e.key === 'ArrowLeft' || e.key === '1') { e.preventDefault(); this.answer(false); }
        if (e.key === 'ArrowRight' || e.key === '2') { e.preventDefault(); this.answer(true); }
        if ((e.key === ' ' || e.key === 'Enter') && !inInput) { e.preventDefault(); this.flip(); }
      }
    }

    // --- Quiz phase ---
    if (this.phase() === 'quiz' && this.currentQuestion) {
      // Enter when answered → next question
      if (this.answered() && (e.key === 'Enter' || e.key === ' ') && !inInput) {
        e.preventDefault();
        this.nextQuestion();
      }
    }
  }

  ngOnInit(): void {
    this.activeCategory = this.route.snapshot.queryParamMap.get('category');
    this.bookmarksMode = this.route.snapshot.queryParamMap.get('mode') === 'bookmarks';
    if (this.bookmarksMode) {
      this.start();
    }
  }

  // --- Select phase ---
  start(): void {
    this.loading.set(true);
    const req = this.bookmarksMode
      ? this.studyService.getBookmarksSession()
      : this.studyService.getSession(this.selectedCount, this.activeCategory ?? undefined);
    req.subscribe({
      next: words => {
        this.words.set(words);
        this.cardIndex.set(0);
        this.flipped.set(false);
        this.flashResults = [];
        this.loading.set(false);
        this.phase.set(words.length > 0 ? 'flashcard' : 'select');
      },
      error: () => this.loading.set(false)
    });
  }

  // --- Flashcard phase ---
  get currentWord(): Word | null {
    return this.words()[this.cardIndex()] || null;
  }

  flip(): void {
    this.flipped.set(!this.flipped());
  }

  answer(correct: boolean): void {
    const word = this.currentWord;
    if (!word) return;

    this.flashResults.push({ word, correct });
    this.progressService.updateProgress(word.id, correct).subscribe();

    const next = this.cardIndex() + 1;
    if (next >= this.words().length) {
      this.loadQuiz();
    } else {
      this.cardIndex.set(next);
      this.flipped.set(false);
    }
  }

  private loadQuiz(): void {
    this.loading.set(true);
    const wordIds = this.words().map(w => w.id);
    this.studyService.getQuizForWords(wordIds).subscribe({
      next: questions => {
        this.questions.set(questions);
        this.questionModes = questions.map(() => 'typing' as QuizMode);
        this.quizIndex.set(0);
        this.selectedOption.set(null);
        this.answered.set(false);
        this.typedAnswer = '';
        this.typeResult.set(null);
        this.quizResults = [];
        this.score.set(0);
        this.loading.set(false);
        this.phase.set('quiz');
      },
      error: () => this.loading.set(false)
    });
  }

  // --- Quiz phase ---
  get currentQuestion(): QuizQuestion | null {
    return this.questions()[this.quizIndex()] || null;
  }

  selectOption(index: number): void {
    if (this.answered()) return;
    this.selectedOption.set(index);
    this.answered.set(true);

    const q = this.currentQuestion!;
    const correct = index === q.correctIndex;
    if (correct) this.score.set(this.score() + 1);

    this.quizResults.push({ question: q, selectedIndex: index, correct });
    this.progressService.updateProgress(q.wordId, correct).subscribe();
  }

  submitTyped(): void {
    if (this.answered() || !this.typedAnswer.trim()) return;

    const q = this.currentQuestion!;
    const correctAnswer = q.word;
    const result = this.checkTypedAnswer(this.typedAnswer, correctAnswer);
    this.typeResult.set(result);
    this.answered.set(true);

    const isCorrect = result === 'correct' || result === 'close';
    if (isCorrect) this.score.set(this.score() + 1);
    this.quizResults.push({ question: q, selectedIndex: -1, correct: isCorrect });
    this.progressService.updateProgress(q.wordId, isCorrect).subscribe();
  }

  private checkTypedAnswer(typed: string, correct: string): TypeResult {
    const norm = (s: string) => s.toLowerCase().trim().replace(/\s+/g, ' ');
    const t = norm(typed);
    const parts = correct.split(/[\/,;]/).map(p => norm(p)).filter(p => p.length > 0);

    if (parts.some(p => p === t)) return 'correct';
    if (parts.some(p => p.includes(t) || t.includes(p))) return 'close';
    return 'wrong';
  }

  nextQuestion(): void {
    const next = this.quizIndex() + 1;
    if (next >= this.questions().length) {
      this.phase.set('done');
    } else {
      this.quizIndex.set(next);
      this.selectedOption.set(null);
      this.answered.set(false);
      this.typedAnswer = '';
      this.typeResult.set(null);
      setTimeout(() => this.typeInput?.nativeElement.focus(), 50);
    }
  }

  getOptionClass(idx: number): string {
    if (!this.answered()) return '';
    const q = this.currentQuestion!;
    if (idx === q.correctIndex) return 'correct';
    if (idx === this.selectedOption() && idx !== q.correctIndex) return 'wrong';
    return 'dimmed';
  }

  get correctAnswerText(): string {
    const q = this.currentQuestion;
    return q ? q.word : '';
  }

  // --- Stats ---
  get flashCorrect(): number {
    return this.flashResults.filter(r => r.correct).length;
  }

  get quizScorePercent(): number {
    const total = this.questions().length;
    return total > 0 ? Math.round((this.score() / total) * 100) : 0;
  }

  restart(): void {
    this.phase.set('select');
    this.words.set([]);
    this.questions.set([]);
    this.flashResults = [];
    this.quizResults = [];
    this.score.set(0);
    this.typedAnswer = '';
    this.typeResult.set(null);
  }
}

import { Component, ElementRef, HostListener, OnInit, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { StudyService } from '../../../core/services/study.service';
import { ProgressService } from '../../../core/services/progress.service';
import { SpeechService } from '../../../core/services/speech.service';
import { KeyboardShortcutService } from '../../../core/services/keyboard-shortcut.service';
import { QuizQuestion } from '../../../core/models/quiz.model';

type Phase = 'intro' | 'quiz' | 'done';
type ReviewMode = 'choice' | 'reverse';
type TypeResult = 'correct' | 'wrong' | null;

@Component({
  selector: 'app-review-session',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './review-session.component.html',
  styleUrls: ['./review-session.component.scss']
})
export class ReviewSessionComponent implements OnInit {
  phase = signal<Phase>('intro');
  loading = signal(true);
  learnedCount = signal(0);

  selectedCount = 20;
  countOptions = [10, 20, 30, 50];

  questions = signal<QuizQuestion[]>([]);
  quizIndex = signal(0);
  selectedOption = signal<number | null>(null);
  answered = signal(false);
  score = signal(0);
  results: { question: QuizQuestion; selectedIndex: number; correct: boolean }[] = [];

  // Per-question mode
  reviewMode: 'mixed' | 'advanced' = 'mixed';
  questionModes: ReviewMode[] = [];
  get currentMode(): ReviewMode { return this.questionModes[this.quizIndex()] ?? 'choice'; }

  // Reverse typing mode
  typedAnswer = '';
  typeResult = signal<TypeResult>(null);
  hintsRevealed = signal(0);
  @ViewChild('typeInput') typeInput?: ElementRef<HTMLInputElement>;

  get wordHintBoxes(): { char: string; blank: boolean }[] {
    const q = this.currentQuestion;
    if (!q) return [];
    return q.word.split('').map((ch, i) => ({
      char: (i === 0 || ch === ' ' || ch === '-') ? ch : '_',
      blank: i !== 0 && ch !== ' ' && ch !== '-'
    }));
  }

  get hintDisplay(): { char: string; revealed: boolean }[] {
    const q = this.currentQuestion;
    if (!q) return [];
    const revealed = this.hintsRevealed();
    return q.word.toLowerCase().split('').map((ch, i) => ({ char: i < revealed ? ch : '_', revealed: i < revealed }));
  }

  constructor(
    private studyService: StudyService,
    private progressService: ProgressService,
    readonly speech: SpeechService,
    readonly kbdService: KeyboardShortcutService
  ) {}

  @HostListener('window:keydown', ['$event'])
  onKey(e: KeyboardEvent): void {
    if (this.phase() !== 'quiz') return;
    const isTyping = e.target instanceof HTMLInputElement || e.target instanceof HTMLTextAreaElement;
    if (this.currentMode === 'choice') {
      if (['1','2','3','4'].includes(e.key) && !this.answered()) {
        e.preventDefault(); this.selectOption(+e.key - 1);
      } else if ((e.key === 'Enter' || e.key === ' ') && this.answered()) {
        e.preventDefault(); this.next();
      }
    } else {
      // reverse/typing mode
      if ((e.key === 'Enter' || e.key === ' ') && this.answered() && !isTyping) {
        e.preventDefault(); this.next();
      } else if (e.key === 'Escape' && this.reviewMode === 'advanced' && !this.answered()) {
        e.preventDefault(); this.giveUp();
      }
    }
  }

  ngOnInit(): void {
    this.studyService.getReviewCount().subscribe({
      next: res => { this.learnedCount.set(res.count); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  startReview(mode: 'mixed' | 'advanced' = 'mixed'): void {
    this.reviewMode = mode;
    this.loading.set(true);
    this.studyService.getReviewQuiz(this.selectedCount).subscribe({
      next: questions => {
        this.questions.set(questions);
        this.questionModes = mode === 'advanced'
          ? questions.map(() => 'reverse' as ReviewMode)
          : questions.map(() => Math.random() < 0.5 ? 'choice' : 'reverse');
        this.quizIndex.set(0);
        this.selectedOption.set(null);
        this.answered.set(false);
        this.typedAnswer = '';
        this.typeResult.set(null);
        this.hintsRevealed.set(0);
        this.results = [];
        this.score.set(0);
        this.loading.set(false);
        this.phase.set('quiz');
      },
      error: () => this.loading.set(false)
    });
  }

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

    this.results.push({ question: q, selectedIndex: index, correct });
    this.progressService.updateProgress(q.wordId, correct).subscribe();
  }

  submitTyped(): void {
    if (this.answered() || !this.typedAnswer.trim()) return;

    const q = this.currentQuestion!;
    const correct = this.typedAnswer.trim().toLowerCase() === q.word.toLowerCase();

    if (correct) {
      this.typeResult.set('correct');
      this.answered.set(true);
      this.score.set(this.score() + 1);
      this.results.push({ question: q, selectedIndex: -1, correct: true });
      this.progressService.updateProgress(q.wordId, true).subscribe();
    } else if (this.reviewMode === 'advanced') {
      // Reveal one more hint letter, let user retry
      const newHints = Math.min(this.hintsRevealed() + 1, q.word.length);
      this.hintsRevealed.set(newHints);
      this.typeResult.set('wrong');
      this.typedAnswer = '';
      if (newHints >= q.word.length) {
        // All letters revealed → finalize as wrong
        this.answered.set(true);
        this.results.push({ question: q, selectedIndex: -1, correct: false });
        this.progressService.updateProgress(q.wordId, false).subscribe();
      } else {
        setTimeout(() => this.typeInput?.nativeElement.focus(), 50);
      }
    } else {
      this.typeResult.set('wrong');
      this.answered.set(true);
      this.results.push({ question: q, selectedIndex: -1, correct: false });
      this.progressService.updateProgress(q.wordId, false).subscribe();
    }
  }

  giveUp(): void {
    if (this.answered()) return;
    const q = this.currentQuestion!;
    this.hintsRevealed.set(q.word.length);
    this.typeResult.set('wrong');
    this.answered.set(true);
    this.results.push({ question: q, selectedIndex: -1, correct: false });
    this.progressService.updateProgress(q.wordId, false).subscribe();
  }

  onTypedAnswerChange(): void {
    if (this.typeResult() === 'wrong' && !this.answered()) {
      this.typeResult.set(null);
    }
  }

  next(): void {
    const next = this.quizIndex() + 1;
    if (next >= this.questions().length) {
      this.phase.set('done');
    } else {
      this.quizIndex.set(next);
      this.selectedOption.set(null);
      this.answered.set(false);
      this.typedAnswer = '';
      this.typeResult.set(null);
      this.hintsRevealed.set(0);
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

  get scorePercent(): number {
    const total = this.questions().length;
    return total > 0 ? Math.round((this.score() / total) * 100) : 0;
  }

  resetToIntro(): void {
    this.loading.set(true);
    this.phase.set('intro');
    this.studyService.getReviewCount().subscribe({
      next: res => { this.learnedCount.set(res.count); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }
}

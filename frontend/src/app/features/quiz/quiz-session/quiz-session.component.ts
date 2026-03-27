import { Component, HostListener, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { QuizService } from '../../../core/services/quiz.service';
import { ProgressService } from '../../../core/services/progress.service';
import { QuizQuestion } from '../../../core/models/quiz.model';
import { KeyboardShortcutService } from '../../../core/services/keyboard-shortcut.service';

@Component({
  selector: 'app-quiz-session',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './quiz-session.component.html',
  styleUrls: ['./quiz-session.component.scss']
})
export class QuizSessionComponent implements OnInit {
  questions = signal<QuizQuestion[]>([]);
  currentIndex = signal(0);
  selectedIndex = signal<number | null>(null);
  answered = signal(false);
  loading = signal(true);
  done = signal(false);
  score = signal(0);
  results: { question: QuizQuestion; selectedIndex: number; correct: boolean }[] = [];

  constructor(
    private quizService: QuizService,
    private progressService: ProgressService,
    readonly kbdService: KeyboardShortcutService
  ) {}

  @HostListener('window:keydown', ['$event'])
  onKey(e: KeyboardEvent): void {
    if (this.done() || this.loading()) return;
    if (['1','2','3','4'].includes(e.key) && !this.answered()) {
      e.preventDefault();
      this.selectOption(+e.key - 1);
    } else if ((e.key === 'Enter' || e.key === ' ') && this.answered()) {
      e.preventDefault();
      this.next();
    }
  }

  ngOnInit(): void {
    this.quizService.getTodayQuiz().subscribe({
      next: questions => { this.questions.set(questions); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  get currentQuestion(): QuizQuestion | null {
    return this.questions()[this.currentIndex()] || null;
  }

  selectOption(index: number): void {
    if (this.answered()) return;
    this.selectedIndex.set(index);
    this.answered.set(true);

    const q = this.currentQuestion!;
    const correct = index === q.correctIndex;

    if (correct) this.score.set(this.score() + 1);

    this.results.push({ question: q, selectedIndex: index, correct });
    this.progressService.updateProgress(q.wordId, correct).subscribe();
  }

  next(): void {
    const nextIdx = this.currentIndex() + 1;
    if (nextIdx >= this.questions().length) {
      this.done.set(true);
    } else {
      this.currentIndex.set(nextIdx);
      this.selectedIndex.set(null);
      this.answered.set(false);
    }
  }

  getOptionClass(idx: number): string {
    if (!this.answered()) return '';
    const q = this.currentQuestion!;
    if (idx === q.correctIndex) return 'correct';
    if (idx === this.selectedIndex() && idx !== q.correctIndex) return 'wrong';
    return 'dimmed';
  }

  get scorePercent(): number {
    return Math.round((this.score() / this.questions().length) * 100);
  }
}

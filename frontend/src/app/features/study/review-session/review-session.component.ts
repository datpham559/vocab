import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';
import { StudyService } from '../../../core/services/study.service';
import { ProgressService } from '../../../core/services/progress.service';
import { QuizQuestion } from '../../../core/models/quiz.model';

type Phase = 'intro' | 'quiz' | 'done';

@Component({
  selector: 'app-review-session',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './review-session.component.html',
  styleUrls: ['./review-session.component.scss']
})
export class ReviewSessionComponent implements OnInit {
  phase = signal<Phase>('intro');
  loading = signal(true);
  reviewCount = signal(0);

  questions = signal<QuizQuestion[]>([]);
  quizIndex = signal(0);
  selectedOption = signal<number | null>(null);
  answered = signal(false);
  score = signal(0);
  results: { question: QuizQuestion; selectedIndex: number; correct: boolean }[] = [];

  constructor(
    private studyService: StudyService,
    private progressService: ProgressService
  ) {}

  ngOnInit(): void {
    this.studyService.getReviewCount().subscribe({
      next: res => { this.reviewCount.set(res.count); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  startReview(): void {
    this.loading.set(true);
    this.studyService.getReviewQuiz().subscribe({
      next: questions => {
        this.questions.set(questions);
        this.quizIndex.set(0);
        this.selectedOption.set(null);
        this.answered.set(false);
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

  next(): void {
    const next = this.quizIndex() + 1;
    if (next >= this.questions().length) {
      this.phase.set('done');
    } else {
      this.quizIndex.set(next);
      this.selectedOption.set(null);
      this.answered.set(false);
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
      next: res => { this.reviewCount.set(res.count); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }
}

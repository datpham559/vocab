import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { StudyService } from '../../../core/services/study.service';
import { ProgressService } from '../../../core/services/progress.service';
import { Word } from '../../../core/models/word.model';
import { QuizQuestion } from '../../../core/models/quiz.model';

type Phase = 'select' | 'flashcard' | 'quiz' | 'done';

@Component({
  selector: 'app-study-session',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './study-session.component.html',
  styleUrls: ['./study-session.component.scss']
})
export class StudySessionComponent {
  phase = signal<Phase>('select');
  loading = signal(false);

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

  constructor(
    private studyService: StudyService,
    private progressService: ProgressService
  ) {}

  // --- Select phase ---
  start(): void {
    this.loading.set(true);
    this.studyService.getSession(this.selectedCount).subscribe({
      next: words => {
        this.words.set(words);
        this.cardIndex.set(0);
        this.flipped.set(false);
        this.flashResults = [];
        this.loading.set(false);
        this.phase.set('flashcard');
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
        this.quizIndex.set(0);
        this.selectedOption.set(null);
        this.answered.set(false);
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

  nextQuestion(): void {
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
  }
}

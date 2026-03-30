import { Component, ElementRef, HostListener, OnInit, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { QuizService } from '../../../core/services/quiz.service';
import { ProgressService } from '../../../core/services/progress.service';
import { QuizQuestion } from '../../../core/models/quiz.model';
import { KeyboardShortcutService } from '../../../core/services/keyboard-shortcut.service';

type Phase = 'intro' | 'quiz' | 'done';
type QuizMode = 'choice' | 'type' | 'mixed';
type QuestionMode = 'choice' | 'type';
type TypeResult = 'correct' | 'wrong' | null;

@Component({
  selector: 'app-quiz-session',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './quiz-session.component.html',
  styleUrls: ['./quiz-session.component.scss']
})
export class QuizSessionComponent implements OnInit {
  phase = signal<Phase>('intro');
  questions = signal<QuizQuestion[]>([]);
  currentIndex = signal(0);
  selectedIndex = signal<number | null>(null);
  answered = signal(false);
  loading = signal(true);
  score = signal(0);
  results: { question: QuizQuestion; selectedIndex: number; correct: boolean }[] = [];

  quizMode: QuizMode = 'choice';
  questionModes: QuestionMode[] = [];
  get currentMode(): QuestionMode { return this.questionModes[this.currentIndex()] ?? 'choice'; }

  // Typing mode
  typedAnswer = '';
  typeResult = signal<TypeResult>(null);
  hintsRevealed = signal(0);
  private answeredAt = 0;
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
    private quizService: QuizService,
    private progressService: ProgressService,
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
      if ((e.key === 'Enter' || e.key === ' ') && this.answered() && !isTyping
          && Date.now() - this.answeredAt > 400) {
        e.preventDefault(); this.next();
      } else if (e.key === 'Escape' && !this.answered()) {
        e.preventDefault(); this.giveUp();
      }
    }
  }

  ngOnInit(): void {
    this.quizService.getTodayQuiz().subscribe({
      next: questions => {
        this.questions.set(questions);
        this.loading.set(false);
        // If user already picked a mode while loading, start quiz
        if (this.phase() === 'quiz') {
          this.applyModes();
        }
      },
      error: () => this.loading.set(false)
    });
  }

  startQuiz(mode: QuizMode): void {
    this.quizMode = mode;
    this.currentIndex.set(0);
    this.selectedIndex.set(null);
    this.answered.set(false);
    this.typedAnswer = '';
    this.typeResult.set(null);
    this.hintsRevealed.set(0);
    this.results = [];
    this.score.set(0);
    this.answeredAt = 0;

    if (!this.loading()) {
      this.applyModes();
      this.phase.set('quiz');
    } else {
      // Mark quiz phase so ngOnInit callback will start it
      this.phase.set('quiz');
    }
  }

  private applyModes(): void {
    const qs = this.questions();
    if (this.quizMode === 'choice') {
      this.questionModes = qs.map(() => 'choice');
    } else if (this.quizMode === 'type') {
      this.questionModes = qs.map(() => 'type');
    } else {
      this.questionModes = qs.map(() => Math.random() < 0.5 ? 'choice' : 'type');
    }
  }

  get currentQuestion(): QuizQuestion | null {
    return this.questions()[this.currentIndex()] || null;
  }

  get wordLetters(): string[] {
    return this.currentQuestion?.word.split('') ?? [];
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

  submitTyped(): void {
    if (this.answered() || !this.typedAnswer.trim()) return;
    const q = this.currentQuestion!;
    const correct = this.typedAnswer.trim().toLowerCase() === q.word.toLowerCase();

    if (correct) {
      this.typeResult.set('correct');
      this.answered.set(true);
      this.answeredAt = Date.now();
      this.score.set(this.score() + 1);
      this.results.push({ question: q, selectedIndex: -1, correct: true });
      this.progressService.updateProgress(q.wordId, true).subscribe();
    } else {
      // Reveal one more hint letter, let user retry
      const newHints = Math.min(this.hintsRevealed() + 1, q.word.length);
      this.hintsRevealed.set(newHints);
      this.typeResult.set('wrong');
      if (newHints >= q.word.length) {
        this.answered.set(true);
        this.answeredAt = Date.now();
        this.results.push({ question: q, selectedIndex: -1, correct: false });
        this.progressService.updateProgress(q.wordId, false).subscribe();
      } else {
        setTimeout(() => {
          this.typeInput?.nativeElement.focus();
          this.typeInput?.nativeElement.select();
        }, 30);
      }
    }
  }

  giveUp(): void {
    if (this.answered()) return;
    const q = this.currentQuestion!;
    this.hintsRevealed.set(q.word.length);
    this.typeResult.set('wrong');
    this.answered.set(true);
    this.answeredAt = Date.now();
    this.results.push({ question: q, selectedIndex: -1, correct: false });
    this.progressService.updateProgress(q.wordId, false).subscribe();
  }

  onTypedAnswerChange(): void {
    if (this.typeResult() === 'wrong' && !this.answered()) {
      this.typeResult.set(null);
    }
  }

  next(): void {
    const nextIdx = this.currentIndex() + 1;
    if (nextIdx >= this.questions().length) {
      this.phase.set('done');
    } else {
      this.currentIndex.set(nextIdx);
      this.selectedIndex.set(null);
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
    if (idx === this.selectedIndex() && idx !== q.correctIndex) return 'wrong';
    return 'dimmed';
  }

  get scorePercent(): number {
    const total = this.questions().length;
    return total > 0 ? Math.round((this.score() / total) * 100) : 0;
  }
}

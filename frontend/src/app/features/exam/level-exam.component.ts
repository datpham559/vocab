import { Component, ElementRef, HostListener, OnDestroy, signal, ViewChild } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { SpeechService } from '../../core/services/speech.service';
import { QuizQuestion } from '../../core/models/quiz.model';
import { KeyboardShortcutService } from '../../core/services/keyboard-shortcut.service';
import { environment } from '../../../environments/environment';

type Phase = 'intro' | 'quiz' | 'result';
type CefrLevel = 'A1' | 'A2' | 'B1' | 'B2' | 'C1' | 'C2';
type ExamMode = 'choice' | 'typing' | 'mixed';
type QuestionMode = 'choice' | 'typing';
type TypeResult = 'correct' | 'wrong' | null;

interface LevelResult {
  cefr: CefrLevel;
  label: string;
  description: string;
  color: string;
  icon: string;
  beginnerScore: number;
  intermediateScore: number;
  advancedScore: number;
  totalCorrect: number;
  totalQuestions: number;
}

const TIME_PER_QUESTION = 15;

@Component({
  selector: 'app-level-exam',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './level-exam.component.html',
  styleUrls: ['./level-exam.component.scss']
})
export class LevelExamComponent implements OnDestroy {
  phase = signal<Phase>('intro');
  loading = signal(false);

  examMode: ExamMode = 'choice';
  selectedCount = 40;
  countOptions = [30, 40, 50, 60];

  questions = signal<QuizQuestion[]>([]);
  currentIndex = signal(0);
  selectedOption = signal<number | null>(null);
  answered = signal(false);
  answers: { question: QuizQuestion; correct: boolean }[] = [];
  timedOut = signal(false);

  // Per-question modes (assigned once on load)
  questionModes: QuestionMode[] = [];
  get currentMode(): QuestionMode { return this.questionModes[this.currentIndex()] ?? 'choice'; }

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

  result: LevelResult | null = null;

  // Timer
  readonly totalTime = TIME_PER_QUESTION;
  timeLeft = signal(TIME_PER_QUESTION);
  private timerInterval: ReturnType<typeof setInterval> | null = null;

  get timerPercent(): number {
    return (this.timeLeft() / this.totalTime) * 100;
  }

  get timerColor(): string {
    const pct = this.timerPercent;
    if (pct > 60) return '#22c55e';
    if (pct > 30) return '#f59e0b';
    return '#ef4444';
  }

  constructor(
    private http: HttpClient,
    readonly speech: SpeechService,
    readonly kbdService: KeyboardShortcutService
  ) {}

  @HostListener('window:keydown', ['$event'])
  onKey(e: KeyboardEvent): void {
    if (this.phase() !== 'quiz') return;
    const isTyping = e.target instanceof HTMLInputElement;

    if (this.currentMode === 'choice') {
      if (['1','2','3','4'].includes(e.key) && !this.answered()) {
        e.preventDefault(); this.selectOption(+e.key - 1);
      } else if ((e.key === 'Enter' || e.key === ' ') && this.answered()) {
        e.preventDefault(); this.next();
      }
    } else {
      if ((e.key === 'Enter' || e.key === ' ') && this.answered() && !isTyping) {
        e.preventDefault(); this.next();
      }
    }
  }

  ngOnDestroy(): void {
    this.clearTimer();
  }

  private startTimer(): void {
    this.clearTimer();
    this.timeLeft.set(TIME_PER_QUESTION);
    this.timedOut.set(false);
    this.timerInterval = setInterval(() => {
      const t = this.timeLeft() - 1;
      this.timeLeft.set(t);
      if (t <= 0) {
        this.clearTimer();
        this.onTimeout();
      }
    }, 1000);
  }

  private clearTimer(): void {
    if (this.timerInterval) {
      clearInterval(this.timerInterval);
      this.timerInterval = null;
    }
  }

  private onTimeout(): void {
    if (this.answered()) return;
    this.timedOut.set(true);
    this.answered.set(true);
    const q = this.currentQuestion!;
    this.answers.push({ question: q, correct: false });
    setTimeout(() => this.next(), 1500);
  }

  startExam(mode: ExamMode = 'choice'): void {
    this.examMode = mode;
    this.loading.set(true);
    this.http.get<QuizQuestion[]>(`${environment.apiUrl}/exam/questions?count=${this.selectedCount}`).subscribe({
      next: questions => {
        this.questions.set(questions);
        this.questionModes = questions.map((_, i) => {
          if (mode === 'choice') return 'choice';
          if (mode === 'typing') return 'typing';
          return i % 2 === 0 ? 'choice' : 'typing';
        });
        this.currentIndex.set(0);
        this.selectedOption.set(null);
        this.answered.set(false);
        this.typedAnswer = '';
        this.typeResult.set(null);
        this.answers = [];
        this.loading.set(false);
        this.phase.set('quiz');
        this.startTimer();
        if (this.questionModes[0] === 'typing') {
          setTimeout(() => this.typeInput?.nativeElement.focus(), 100);
        }
      },
      error: () => this.loading.set(false)
    });
  }

  get currentQuestion(): QuizQuestion | null {
    return this.questions()[this.currentIndex()] || null;
  }

  selectOption(index: number): void {
    if (this.answered()) return;
    this.clearTimer();
    this.timedOut.set(false);
    this.selectedOption.set(index);
    this.answered.set(true);
    const q = this.currentQuestion!;
    this.answers.push({ question: q, correct: index === q.correctIndex });
  }

  submitTyped(): void {
    if (this.answered() || !this.typedAnswer.trim()) return;
    this.clearTimer();
    this.timedOut.set(false);
    const q = this.currentQuestion!;
    const correct = this.typedAnswer.trim().toLowerCase() === q.word.toLowerCase();
    this.typeResult.set(correct ? 'correct' : 'wrong');
    this.answered.set(true);
    this.answers.push({ question: q, correct });
  }

  next(): void {
    const nextIdx = this.currentIndex() + 1;
    if (nextIdx >= this.questions().length) {
      this.clearTimer();
      this.calculateResult();
    } else {
      this.currentIndex.set(nextIdx);
      this.selectedOption.set(null);
      this.answered.set(false);
      this.timedOut.set(false);
      this.typedAnswer = '';
      this.typeResult.set(null);
      this.startTimer();
      if (this.questionModes[nextIdx] === 'typing') {
        setTimeout(() => this.typeInput?.nativeElement.focus(), 50);
      }
    }
  }

  private calculateResult(): void {
    const byLevel = (level: string) => {
      const group = this.answers.filter(a => a.question.difficulty === level);
      return group.length > 0 ? group.filter(a => a.correct).length / group.length : 0;
    };

    const bScore = byLevel('BEGINNER');
    const iScore = byLevel('INTERMEDIATE');
    const aScore = byLevel('ADVANCED');

    let cefr: CefrLevel;
    if (aScore >= 0.7 && iScore >= 0.6 && bScore >= 0.6) {
      cefr = aScore >= 0.9 ? 'C2' : 'C1';
    } else if (iScore >= 0.65 && bScore >= 0.5) {
      cefr = 'B2';
    } else if (iScore >= 0.4 || (bScore >= 0.7 && iScore >= 0.2)) {
      cefr = 'B1';
    } else if (bScore >= 0.5) {
      cefr = 'A2';
    } else {
      cefr = 'A1';
    }

    const labels: Record<CefrLevel, { label: string; description: string; color: string; icon: string }> = {
      A1: { label: 'Mới bắt đầu',    description: 'Bạn đang ở bước khởi đầu. Hãy tập trung học những từ cơ bản mỗi ngày — kiên trì là chìa khóa!',         color: '#94a3b8', icon: '🌱' },
      A2: { label: 'Sơ cấp',         description: 'Bạn đã nắm nền tảng cơ bản. Tiếp tục mở rộng vốn từ thường dùng hàng ngày!',                             color: '#22c55e', icon: '📗' },
      B1: { label: 'Trung cấp thấp', description: 'Bạn xử lý được nhiều tình huống giao tiếp. Luyện thêm từ học thuật và công việc để lên B2!',              color: '#3b82f6', icon: '📘' },
      B2: { label: 'Trung cấp cao',  description: 'Vốn từ của bạn khá phong phú. Thử thách với từ nâng cao — bứt phá lên C chỉ còn một bước!',              color: '#f59e0b', icon: '⭐' },
      C1: { label: 'Nâng cao',       description: 'Bạn dùng tiếng Anh thành thạo. Tiếp tục trau dồi từ học thuật, chuyên ngành để đạt C2!',                 color: '#8b5cf6', icon: '🏅' },
      C2: { label: 'Thành thạo',     description: 'Xuất sắc! Vốn từ vựng của bạn ở mức thành thạo. Hãy duy trì và tiếp tục mở rộng!',                      color: '#6366f1', icon: '🏆' }
    };

    const totalCorrect = this.answers.filter(a => a.correct).length;

    this.result = {
      cefr, ...labels[cefr],
      beginnerScore: Math.round(bScore * 100),
      intermediateScore: Math.round(iScore * 100),
      advancedScore: Math.round(aScore * 100),
      totalCorrect,
      totalQuestions: this.answers.length
    };

    this.phase.set('result');
  }

  getOptionClass(idx: number): string {
    if (!this.answered()) return '';
    const q = this.currentQuestion!;
    if (idx === q.correctIndex) return 'correct';
    if (idx === this.selectedOption() && idx !== q.correctIndex) return 'wrong';
    return 'dimmed';
  }

  restart(): void {
    this.clearTimer();
    this.phase.set('intro');
    this.result = null;
  }
}

import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, RouterLink } from '@angular/router';
import { DailyWordSetService } from '../../../core/services/daily-word-set.service';
import { ProgressService } from '../../../core/services/progress.service';
import { DailyWordSet } from '../../../core/models/daily-word-set.model';
import { Word } from '../../../core/models/word.model';

@Component({
  selector: 'app-flashcard-session',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './flashcard-session.component.html',
  styleUrls: ['./flashcard-session.component.scss']
})
export class FlashcardSessionComponent implements OnInit {
  dailySet = signal<DailyWordSet | null>(null);
  currentIndex = signal(0);
  flipped = signal(false);
  loading = signal(true);
  done = signal(false);
  results: { word: Word; correct: boolean }[] = [];

  constructor(
    private dailySetService: DailyWordSetService,
    private progressService: ProgressService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.dailySetService.getTodaySet().subscribe({
      next: set => { this.dailySet.set(set); this.loading.set(false); },
      error: () => this.loading.set(false)
    });
  }

  get currentWord(): Word | null {
    const set = this.dailySet();
    if (!set) return null;
    return set.words[this.currentIndex()] || null;
  }

  get totalWords(): number {
    return this.dailySet()?.words.length || 0;
  }

  flip(): void {
    this.flipped.set(!this.flipped());
  }

  answer(correct: boolean): void {
    const word = this.currentWord;
    if (!word) return;

    this.results.push({ word, correct });
    this.progressService.updateProgress(word.id, correct).subscribe();

    const next = this.currentIndex() + 1;
    if (next >= this.totalWords) {
      this.done.set(true);
      const setId = this.dailySet()!.id;
      this.dailySetService.markCompleted(setId).subscribe();
    } else {
      this.currentIndex.set(next);
      this.flipped.set(false);
    }
  }

  get correctCount(): number {
    return this.results.filter(r => r.correct).length;
  }

  goToQuiz(): void {
    this.router.navigate(['/quiz']);
  }
}

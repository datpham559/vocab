import { Component, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router, RouterLink } from '@angular/router';
import { RoomService } from '../../../core/services/room.service';

@Component({
  selector: 'app-room-lobby',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './room-lobby.component.html',
  styleUrls: ['./room-lobby.component.scss']
})
export class RoomLobbyComponent {
  tab: 'create' | 'join' = 'create';
  loading = signal(false);
  error = signal('');

  // Create — standard
  configMode: 'standard' | 'custom' = 'standard';
  questionCount = 20;
  countOptions = [10, 20, 30];
  quizMode: 'CHOICE' | 'TYPE' | 'MIXED' = 'CHOICE';

  // Create — custom difficulty counts (matches standard 20q ratio: 40/40/20)
  beginnerCount = 8;
  intermediateCount = 8;
  advancedCount = 4;
  readonly MAX_PER_DIFF = 20;

  // Per-difficulty question modes (only used when quizMode=MIXED + configMode=custom)
  beginnerMode: 'CHOICE' | 'TYPE' | 'MIXED' = 'MIXED';
  intermediateMode: 'CHOICE' | 'TYPE' | 'MIXED' = 'MIXED';
  advancedMode: 'CHOICE' | 'TYPE' | 'MIXED' = 'MIXED';

  // Join
  joinCode = '';

  constructor(private roomService: RoomService, private router: Router) {}

  get totalCustomCount(): number {
    return this.beginnerCount + this.intermediateCount + this.advancedCount;
  }

  get isCustomValid(): boolean {
    return this.totalCustomCount >= 1 && this.totalCustomCount <= 50;
  }

  adjustCount(diff: 'beginner' | 'intermediate' | 'advanced', delta: number): void {
    if (diff === 'beginner') {
      this.beginnerCount = Math.max(0, Math.min(this.MAX_PER_DIFF, this.beginnerCount + delta));
    } else if (diff === 'intermediate') {
      this.intermediateCount = Math.max(0, Math.min(this.MAX_PER_DIFF, this.intermediateCount + delta));
    } else {
      this.advancedCount = Math.max(0, Math.min(this.MAX_PER_DIFF, this.advancedCount + delta));
    }
  }

  createRoom(): void {
    this.loading.set(true);
    this.error.set('');
    const body = this.configMode === 'custom'
      ? {
          quizMode: this.quizMode,
          beginnerCount: this.beginnerCount,
          intermediateCount: this.intermediateCount,
          advancedCount: this.advancedCount,
          ...(this.quizMode === 'MIXED' ? {
            beginnerMode: this.beginnerMode,
            intermediateMode: this.intermediateMode,
            advancedMode: this.advancedMode
          } : {})
        }
      : { questionCount: this.questionCount, quizMode: this.quizMode };
    this.roomService.createRoom(body).subscribe({
      next: res => this.router.navigate(['/room', res.code]),
      error: () => { this.error.set('Không thể tạo phòng.'); this.loading.set(false); }
    });
  }

  joinRoom(): void {
    const code = this.joinCode.trim().toUpperCase();
    if (!code) return;
    this.loading.set(true);
    this.error.set('');
    this.roomService.joinRoom(code).subscribe({
      next: () => this.router.navigate(['/room', code]),
      error: () => { this.error.set('Không tìm thấy phòng hoặc phòng đã kết thúc.'); this.loading.set(false); }
    });
  }

  spectateRoom(): void {
    const code = this.joinCode.trim().toUpperCase();
    if (!code) return;
    this.loading.set(true);
    this.error.set('');
    this.roomService.spectateRoom(code).subscribe({
      next: () => this.router.navigate(['/room', code], { queryParams: { spectator: '1' } }),
      error: () => { this.error.set('Không tìm thấy phòng hoặc phòng đã kết thúc.'); this.loading.set(false); }
    });
  }
}

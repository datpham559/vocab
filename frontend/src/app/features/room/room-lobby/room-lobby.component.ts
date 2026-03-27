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

  // Create
  questionCount = 20;
  countOptions = [10, 20, 30];

  // Join
  joinCode = '';

  constructor(private roomService: RoomService, private router: Router) {}

  createRoom(): void {
    this.loading.set(true);
    this.error.set('');
    this.roomService.createRoom(this.questionCount).subscribe({
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
}

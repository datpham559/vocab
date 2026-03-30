import { Component, OnInit, signal, inject } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { ProfileService, ProfileData } from '../../core/services/profile.service';
import { AuthService } from '../../core/services/auth.service';
import { ActivityLogService, ActivityLogEntry } from '../../core/services/activity-log.service';

@Component({
  selector: 'app-profile',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.scss']
})
export class ProfileComponent implements OnInit {
  private profileService = inject(ProfileService);
  private logService = inject(ActivityLogService);
  authService = inject(AuthService);

  myLogs = signal<ActivityLogEntry[]>([]);
  logsLoading = signal(false);

  profile = signal<ProfileData | null>(null);
  loading = signal(true);
  errorMsg = signal('');

  // Edit display name
  editingName = false;
  newDisplayName = '';
  nameLoading = signal(false);
  nameSuccess = signal(false);
  nameError = signal('');

  // Change password
  showPasswordForm = false;
  currentPassword = '';
  newPassword = '';
  confirmPassword = '';
  pwdLoading = signal(false);
  pwdSuccess = signal(false);
  pwdError = signal('');

  ngOnInit(): void {
    this.profileService.getProfile().subscribe({
      next: (data) => { this.profile.set(data); this.loading.set(false); },
      error: () => { this.errorMsg.set('Không thể tải thông tin hồ sơ'); this.loading.set(false); }
    });
    this.logsLoading.set(true);
    this.logService.getMy().subscribe({
      next: (logs) => { this.myLogs.set(logs.slice(0, 30)); this.logsLoading.set(false); },
      error: () => this.logsLoading.set(false)
    });
  }

  actionLabel(type: string): string {
    const map: Record<string, string> = {
      LOGIN: 'Đăng nhập', REGISTER: 'Đăng ký',
      STUDY_STARTED: 'Học từ', REVIEW_STARTED: 'Ôn tập',
      EXAM_STARTED: 'Kiểm tra', PROFILE_UPDATED: 'Cập nhật hồ sơ',
      ROOM_CREATED: 'Tạo phòng', ROOM_JOINED: 'Vào phòng'
    };
    return map[type] ?? type;
  }

  formatDatetime(iso: string): string {
    return new Date(iso).toLocaleString('vi-VN');
  }

  getInitials(): string {
    const name = this.profile()?.displayName || this.profile()?.username || '?';
    return name.split(' ').map(w => w[0]).join('').toUpperCase().slice(0, 2);
  }

  startEditName(): void {
    this.newDisplayName = this.profile()?.displayName || '';
    this.editingName = true;
    this.nameError.set('');
    this.nameSuccess.set(false);
  }

  cancelEditName(): void {
    this.editingName = false;
    this.nameError.set('');
  }

  saveName(): void {
    if (!this.newDisplayName.trim()) return;
    this.nameLoading.set(true);
    this.nameError.set('');

    this.profileService.updateProfile({ displayName: this.newDisplayName.trim() }).subscribe({
      next: (updated) => {
        this.profile.set(updated);
        this.authService.updateDisplayName(updated.displayName);
        this.editingName = false;
        this.nameLoading.set(false);
        this.nameSuccess.set(true);
        setTimeout(() => this.nameSuccess.set(false), 3000);
      },
      error: () => {
        this.nameError.set('Có lỗi xảy ra, thử lại sau.');
        this.nameLoading.set(false);
      }
    });
  }

  savePassword(): void {
    this.pwdError.set('');
    if (this.newPassword !== this.confirmPassword) {
      this.pwdError.set('Mật khẩu xác nhận không khớp');
      return;
    }
    if (this.newPassword.length < 6) {
      this.pwdError.set('Mật khẩu mới phải có ít nhất 6 ký tự');
      return;
    }

    this.pwdLoading.set(true);
    this.profileService.updateProfile({
      currentPassword: this.currentPassword,
      newPassword: this.newPassword
    }).subscribe({
      next: () => {
        this.pwdLoading.set(false);
        this.pwdSuccess.set(true);
        this.showPasswordForm = false;
        this.currentPassword = '';
        this.newPassword = '';
        this.confirmPassword = '';
        setTimeout(() => this.pwdSuccess.set(false), 4000);
      },
      error: (err) => {
        this.pwdError.set(err.error || 'Mật khẩu hiện tại không đúng');
        this.pwdLoading.set(false);
      }
    });
  }

  formatDate(dateStr: string): string {
    const d = new Date(dateStr);
    return d.toLocaleDateString('vi-VN', { year: 'numeric', month: 'long', day: 'numeric' });
  }

  get totalWords(): number {
    const p = this.profile();
    if (!p) return 0;
    return p.newCount + p.learningCount + p.reviewCount + p.masteredCount;
  }

  pct(count: number): number {
    const total = this.totalWords;
    return total > 0 ? Math.round((count / total) * 100) : 0;
  }
}

import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { RouterLink } from '@angular/router';
import { AdminService, WordLookupResult, CreateWordPayload } from '../../core/services/admin.service';
import { AuthService } from '../../core/services/auth.service';
import { ActivityLogService, ActivityLogEntry, LogPage } from '../../core/services/activity-log.service';
import { AdminUser } from '../../core/models/user.model';

const DIFFICULTIES = ['BEGINNER', 'INTERMEDIATE', 'ADVANCED'];
const CATEGORIES = [
  'Achievement','Actions','Animals','Body','Business','Character','Clothing',
  'Communication','Culture','Descriptive','Education','Emotions','Entertainment',
  'Food','General','Health','Home','Language','Nature','People','Places',
  'Politics','Shopping','Social','Technology','Thinking','Time','Transport','Travel','Work'
];

@Component({
  selector: 'app-admin-panel',
  standalone: true,
  imports: [CommonModule, FormsModule, RouterLink],
  templateUrl: './admin-panel.component.html',
  styleUrls: ['./admin-panel.component.scss']
})
export class AdminPanelComponent implements OnInit {
  activeTab: 'users' | 'words' | 'logs' = 'users';

  // --- logs tab ---
  logs = signal<ActivityLogEntry[]>([]);
  logsTotalPages = signal(0);
  logsTotalElements = signal(0);
  logsPage = signal(0);
  logsLoading = signal(false);
  logsActionFilter = '';
  logsUsernameFilter = '';
  readonly ACTION_TYPES = ['LOGIN','REGISTER','STUDY_STARTED','REVIEW_STARTED',
                           'EXAM_STARTED','PROFILE_UPDATED','ROOM_CREATED','ROOM_JOINED'];

  // --- users tab ---
  users = signal<AdminUser[]>([]);
  loading = signal(true);
  errorMsg = signal('');

  // --- words tab ---
  readonly difficulties = DIFFICULTIES;
  readonly categories = CATEGORIES;

  lookupTerm = '';
  lookupLoading = signal(false);
  lookupResult = signal<WordLookupResult | null>(null);
  lookupError = signal('');
  manualMode = false;

  form: CreateWordPayload = this.emptyForm();
  saveLoading = signal(false);
  saveSuccess = signal(false);
  saveError = signal('');

  constructor(
    private adminService: AdminService,
    private logService: ActivityLogService,
    readonly authService: AuthService
  ) {}

  ngOnInit(): void {
    this.loadUsers();
  }

  loadUsers(): void {
    this.loading.set(true);
    this.adminService.getUsers().subscribe({
      next: users => { this.users.set(users); this.loading.set(false); },
      error: () => { this.errorMsg.set('Không thể tải danh sách người dùng.'); this.loading.set(false); }
    });
  }

  toggleRole(user: AdminUser): void {
    const newRole = user.role === 'ROLE_ADMIN' ? 'ROLE_USER' : 'ROLE_ADMIN';
    this.adminService.updateRole(user.id, newRole).subscribe({
      next: updated => {
        this.users.update(list => list.map(u => u.id === updated.id ? updated : u));
      }
    });
  }

  deleteUser(user: AdminUser): void {
    if (!confirm(`Xóa tài khoản "${user.username}"? Hành động này không thể hoàn tác.`)) return;
    this.adminService.deleteUser(user.id).subscribe({
      next: () => this.users.update(list => list.filter(u => u.id !== user.id))
    });
  }

  isCurrentUser(user: AdminUser): boolean {
    return this.authService.currentUser()?.userId === user.id;
  }

  formatDate(dateStr: string | null): string {
    if (!dateStr) return '—';
    return new Date(dateStr).toLocaleDateString('vi-VN');
  }

  // --- word lookup ---
  lookupWord(): void {
    const term = this.lookupTerm.trim();
    if (!term) return;
    this.lookupLoading.set(true);
    this.lookupResult.set(null);
    this.lookupError.set('');
    this.saveSuccess.set(false);
    this.saveError.set('');

    this.adminService.lookupWord(term).subscribe({
      next: result => {
        this.lookupResult.set(result);
        if (!result.existsInDb) {
          this.form = {
            word: result.word ?? term.toLowerCase(),
            pronunciation: result.pronunciation ?? '',
            meaningVi: result.meaningVi ?? '',
            partOfSpeech: result.partOfSpeech ?? '',
            difficulty: result.difficulty ?? 'BEGINNER',
            category: result.category ?? '',
            exampleSentence: result.exampleSentence ?? '',
            exampleTranslation: result.exampleTranslation ?? '',
          };
        }
        this.lookupLoading.set(false);
      },
      error: () => {
        this.lookupError.set('Không thể tra cứu từ này.');
        this.lookupLoading.set(false);
      }
    });
  }

  saveWord(): void {
    this.saveLoading.set(true);
    this.saveSuccess.set(false);
    this.saveError.set('');

    this.adminService.createWord(this.form).subscribe({
      next: () => {
        this.saveLoading.set(false);
        this.saveSuccess.set(true);
        this.lookupResult.set(null);
        this.lookupTerm = '';
        this.manualMode = false;
        this.form = this.emptyForm();
      },
      error: (err) => {
        this.saveLoading.set(false);
        this.saveError.set(err?.error?.message ?? 'Lưu thất bại. Vui lòng kiểm tra lại.');
      }
    });
  }

  openManual(): void {
    this.lookupResult.set(null);
    this.lookupError.set('');
    this.saveSuccess.set(false);
    this.saveError.set('');
    this.form = this.emptyForm();
    this.manualMode = true;
  }

  resetLookup(): void {
    this.lookupTerm = '';
    this.lookupResult.set(null);
    this.lookupError.set('');
    this.saveSuccess.set(false);
    this.saveError.set('');
    this.manualMode = false;
    this.form = this.emptyForm();
  }

  private emptyForm(): CreateWordPayload {
    return { word: '', pronunciation: '', meaningVi: '', partOfSpeech: '', difficulty: 'BEGINNER', category: '', exampleSentence: '', exampleTranslation: '' };
  }

  // --- logs tab ---
  loadLogs(page = 0): void {
    this.logsLoading.set(true);
    this.logsPage.set(page);
    this.logService.getAll(page, 50, this.logsActionFilter || undefined, this.logsUsernameFilter || undefined)
      .subscribe({
        next: (res: LogPage) => {
          this.logs.set(res.content);
          this.logsTotalPages.set(res.totalPages);
          this.logsTotalElements.set(res.totalElements);
          this.logsLoading.set(false);
        },
        error: () => this.logsLoading.set(false)
      });
  }

  switchToLogs(): void {
    this.activeTab = 'logs';
    if (this.logs().length === 0) this.loadLogs(0);
  }

  applyLogFilter(): void { this.loadLogs(0); }
  clearLogFilter(): void { this.logsActionFilter = ''; this.logsUsernameFilter = ''; this.loadLogs(0); }

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
}

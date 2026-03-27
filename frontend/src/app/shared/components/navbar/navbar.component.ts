import { Component, OnInit, signal } from '@angular/core';
import { RouterLink, RouterLinkActive } from '@angular/router';
import { CommonModule } from '@angular/common';
import { AuthService } from '../../../core/services/auth.service';
import { StudyService } from '../../../core/services/study.service';
import { KeyboardShortcutService } from '../../../core/services/keyboard-shortcut.service';
import { ThemeService } from '../../../core/services/theme.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [RouterLink, RouterLinkActive, CommonModule],
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.scss']
})
export class NavbarComponent implements OnInit {
  reviewCount = signal(0);

  constructor(
    readonly authService: AuthService,
    private studyService: StudyService,
    readonly kbdService: KeyboardShortcutService,
    readonly themeService: ThemeService
  ) {}

  ngOnInit(): void {
    if (this.authService.currentUser()) {
      this.studyService.getReviewCount().subscribe({
        next: res => this.reviewCount.set(res.count),
        error: () => {}
      });
    }
  }

  logout(): void {
    this.authService.logout();
  }
}

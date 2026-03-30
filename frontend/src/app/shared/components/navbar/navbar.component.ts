import { Component, OnInit, signal } from '@angular/core';
import { RouterLink, RouterLinkActive, Router, NavigationEnd } from '@angular/router';
import { CommonModule } from '@angular/common';
import { filter } from 'rxjs/operators';
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
  isStudyActive = false;
  isWordsActive = false;

  private readonly studyPaths = ['/study', '/review', '/favorites', '/flashcard', '/quiz'];
  private readonly wordsPaths = ['/words', '/topics'];

  constructor(
    readonly authService: AuthService,
    private studyService: StudyService,
    readonly kbdService: KeyboardShortcutService,
    readonly themeService: ThemeService,
    private router: Router
  ) {}

  ngOnInit(): void {
    this.updateActive(this.router.url);
    this.router.events.pipe(filter(e => e instanceof NavigationEnd)).subscribe((e: any) => {
      this.updateActive(e.urlAfterRedirects);
    });
    if (this.authService.currentUser()) {
      this.studyService.getReviewCount().subscribe({
        next: res => this.reviewCount.set(res.count),
        error: () => {}
      });
    }
  }

  private updateActive(url: string): void {
    this.isStudyActive = this.studyPaths.some(p => url.startsWith(p));
    this.isWordsActive = this.wordsPaths.some(p => url.startsWith(p));
  }

  logout(): void {
    this.authService.logout();
  }
}

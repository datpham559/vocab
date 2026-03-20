import { Component, computed } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { NavbarComponent } from './shared/components/navbar/navbar.component';
import { AuthService } from './core/services/auth.service';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, NavbarComponent, CommonModule],
  template: `
    <app-navbar *ngIf="showNav()" />
    <main [class.with-nav]="showNav()">
      <router-outlet />
    </main>
  `,
  styles: [`
    main { min-height: 100vh; }
    main.with-nav { padding-top: 64px; }
  `]
})
export class AppComponent {
  showNav = computed(() => this.authService.isAuthenticated());
  constructor(private authService: AuthService) {}
}

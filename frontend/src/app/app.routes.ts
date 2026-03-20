import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth.guard';
import { guestGuard } from './core/guards/guest.guard';

export const routes: Routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full' },
  {
    path: 'auth',
    canActivate: [guestGuard],
    children: [
      { path: '', redirectTo: 'login', pathMatch: 'full' },
      {
        path: 'login',
        loadComponent: () => import('./features/auth/login/login.component').then(m => m.LoginComponent)
      },
      {
        path: 'register',
        loadComponent: () => import('./features/auth/register/register.component').then(m => m.RegisterComponent)
      }
    ]
  },
  {
    path: 'dashboard',
    canActivate: [authGuard],
    loadComponent: () => import('./features/dashboard/dashboard.component').then(m => m.DashboardComponent)
  },
  {
    path: 'flashcard',
    canActivate: [authGuard],
    loadComponent: () => import('./features/flashcard/flashcard-session/flashcard-session.component').then(m => m.FlashcardSessionComponent)
  },
  {
    path: 'quiz',
    canActivate: [authGuard],
    loadComponent: () => import('./features/quiz/quiz-session/quiz-session.component').then(m => m.QuizSessionComponent)
  },
  {
    path: 'study',
    canActivate: [authGuard],
    loadComponent: () => import('./features/study/study-session/study-session.component').then(m => m.StudySessionComponent)
  },
  {
    path: 'review',
    canActivate: [authGuard],
    loadComponent: () => import('./features/study/review-session/review-session.component').then(m => m.ReviewSessionComponent)
  },
  {
    path: 'words',
    canActivate: [authGuard],
    loadComponent: () => import('./features/word-list/word-list.component').then(m => m.WordListComponent)
  },
  { path: '**', redirectTo: '/dashboard' }
];

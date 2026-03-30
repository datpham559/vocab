import { Routes } from '@angular/router';
import { authGuard } from './core/guards/auth.guard';
import { guestGuard } from './core/guards/guest.guard';
import { adminGuard } from './core/guards/admin.guard';

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
  {
    path: 'topics',
    canActivate: [authGuard],
    loadComponent: () => import('./features/topics/topics.component').then(m => m.TopicsComponent)
  },
  {
    path: 'exam',
    loadComponent: () => import('./features/exam/level-exam.component').then(m => m.LevelExamComponent)
  },
  {
    path: 'room',
    canActivate: [authGuard],
    loadComponent: () => import('./features/room/room-lobby/room-lobby.component').then(m => m.RoomLobbyComponent)
  },
  {
    path: 'room/:code',
    canActivate: [authGuard],
    loadComponent: () => import('./features/room/room-game/room-game.component').then(m => m.RoomGameComponent)
  },
  {
    path: 'leaderboard',
    canActivate: [authGuard],
    loadComponent: () => import('./features/leaderboard/leaderboard.component').then(m => m.LeaderboardComponent)
  },
  {
    path: 'profile',
    canActivate: [authGuard],
    loadComponent: () => import('./features/profile/profile.component').then(m => m.ProfileComponent)
  },
  {
    path: 'favorites',
    canActivate: [authGuard],
    loadComponent: () => import('./features/favorites/favorites.component').then(m => m.FavoritesComponent)
  },
  {
    path: 'admin',
    canActivate: [authGuard, adminGuard],
    loadComponent: () => import('./features/admin/admin-panel.component').then(m => m.AdminPanelComponent)
  },
  { path: '**', redirectTo: '/dashboard' }
];

export interface User {
  userId: number;
  username: string;
  email: string;
  displayName: string;
  token: string;
  role: string;
}

export interface AuthResponse {
  token: string;
  tokenType: string;
  userId: number;
  username: string;
  email: string;
  displayName: string;
  role: string;
}

export interface AdminUser {
  id: number;
  username: string;
  email: string;
  displayName: string;
  role: string;
  streak: number;
  totalWordsLearned: number;
  lastStudyDate: string | null;
  createdAt: string;
}

export interface LoginRequest {
  username: string;
  password: string;
}

export interface RegisterRequest {
  username: string;
  email: string;
  password: string;
  displayName?: string;
}

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

export interface ProfileData {
  userId: number;
  username: string;
  email: string;
  displayName: string;
  role: string;
  streak: number;
  totalWordsLearned: number;
  createdAt: string;
  newCount: number;
  learningCount: number;
  reviewCount: number;
  masteredCount: number;
  totalDaysStudied: number;
}

export interface UpdateProfileRequest {
  displayName?: string;
  currentPassword?: string;
  newPassword?: string;
}

@Injectable({ providedIn: 'root' })
export class ProfileService {
  constructor(private http: HttpClient) {}

  getProfile(): Observable<ProfileData> {
    return this.http.get<ProfileData>(`${environment.apiUrl}/profile`);
  }

  updateProfile(request: UpdateProfileRequest): Observable<ProfileData> {
    return this.http.put<ProfileData>(`${environment.apiUrl}/profile`, request);
  }
}

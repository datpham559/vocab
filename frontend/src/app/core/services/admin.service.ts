import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { AdminUser } from '../models/user.model';

export interface WordLookupResult {
  existsInDb: boolean;
  word: string;
  pronunciation?: string;
  partOfSpeech?: string;
  meaningVi?: string;
  exampleSentence?: string;
  exampleTranslation?: string;
  difficulty?: string;
  category?: string;
}

export interface CreateWordPayload {
  word: string;
  pronunciation?: string;
  meaningVi: string;
  partOfSpeech?: string;
  difficulty: string;
  category?: string;
  exampleSentence?: string;
  exampleTranslation?: string;
}

@Injectable({ providedIn: 'root' })
export class AdminService {
  private readonly base = `${environment.apiUrl}/admin`;
  private readonly wordsBase = `${environment.apiUrl}/words`;

  constructor(private http: HttpClient) {}

  getUsers(): Observable<AdminUser[]> {
    return this.http.get<AdminUser[]>(`${this.base}/users`);
  }

  updateRole(userId: number, role: string): Observable<AdminUser> {
    return this.http.patch<AdminUser>(`${this.base}/users/${userId}/role`, { role });
  }

  deleteUser(userId: number): Observable<void> {
    return this.http.delete<void>(`${this.base}/users/${userId}`);
  }

  lookupWord(word: string): Observable<WordLookupResult> {
    return this.http.get<WordLookupResult>(`${this.wordsBase}/lookup`, { params: { word } });
  }

  createWord(payload: CreateWordPayload): Observable<unknown> {
    return this.http.post(`${this.wordsBase}`, payload);
  }
}

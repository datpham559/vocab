import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { UserWordProgress } from '../models/word.model';

@Injectable({ providedIn: 'root' })
export class ProgressService {
  private readonly base = `${environment.apiUrl}/progress`;

  constructor(private http: HttpClient) {}

  getMyProgress(): Observable<UserWordProgress[]> {
    return this.http.get<UserWordProgress[]>(this.base);
  }

  updateProgress(wordId: number, correct: boolean): Observable<UserWordProgress> {
    return this.http.patch<UserWordProgress>(`${this.base}/${wordId}`, { correct });
  }
}

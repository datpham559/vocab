import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { Word } from '../models/word.model';
import { QuizQuestion } from '../models/quiz.model';

@Injectable({ providedIn: 'root' })
export class StudyService {
  private readonly base = `${environment.apiUrl}/study`;

  constructor(private http: HttpClient) {}

  getSession(count: number): Observable<Word[]> {
    return this.http.get<Word[]>(`${this.base}/session`, {
      params: new HttpParams().set('count', count)
    });
  }

  getQuizForWords(wordIds: number[]): Observable<QuizQuestion[]> {
    return this.http.get<QuizQuestion[]>(`${this.base}/quiz`, {
      params: new HttpParams().set('wordIds', wordIds.join(','))
    });
  }

  getReviewQuiz(): Observable<QuizQuestion[]> {
    return this.http.get<QuizQuestion[]>(`${this.base}/review`);
  }

  getReviewCount(): Observable<{ count: number }> {
    return this.http.get<{ count: number }>(`${this.base}/review/count`);
  }
}

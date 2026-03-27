import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { Word } from '../models/word.model';
import { QuizQuestion } from '../models/quiz.model';

export interface CategoryInfo {
  category: string;
  wordCount: number;
}

@Injectable({ providedIn: 'root' })
export class StudyService {
  private readonly base = `${environment.apiUrl}/study`;

  constructor(private http: HttpClient) {}

  getCategories(): Observable<CategoryInfo[]> {
    return this.http.get<CategoryInfo[]>(`${this.base}/categories`);
  }

  getSession(count: number, category?: string): Observable<Word[]> {
    let params = new HttpParams().set('count', count);
    if (category) params = params.set('category', category);
    return this.http.get<Word[]>(`${this.base}/session`, { params });
  }

  getQuizForWords(wordIds: number[]): Observable<QuizQuestion[]> {
    return this.http.get<QuizQuestion[]>(`${this.base}/quiz`, {
      params: new HttpParams().set('wordIds', wordIds.join(','))
    });
  }

  getReviewQuiz(count: number = 20): Observable<QuizQuestion[]> {
    return this.http.get<QuizQuestion[]>(`${this.base}/review`, {
      params: new HttpParams().set('count', count)
    });
  }

  getReviewCount(): Observable<{ count: number }> {
    return this.http.get<{ count: number }>(`${this.base}/review/count`);
  }
}

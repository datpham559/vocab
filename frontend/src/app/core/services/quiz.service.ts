import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { QuizQuestion } from '../models/quiz.model';

@Injectable({ providedIn: 'root' })
export class QuizService {
  private readonly base = `${environment.apiUrl}/quiz`;

  constructor(private http: HttpClient) {}

  getTodayQuiz(): Observable<QuizQuestion[]> {
    return this.http.get<QuizQuestion[]>(`${this.base}/today`);
  }
}

import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { DailyWordSet } from '../models/daily-word-set.model';

@Injectable({ providedIn: 'root' })
export class DailyWordSetService {
  private readonly base = `${environment.apiUrl}/daily-word-sets`;

  constructor(private http: HttpClient) {}

  getTodaySet(): Observable<DailyWordSet> {
    return this.http.get<DailyWordSet>(`${this.base}/today`);
  }

  markCompleted(setId: number): Observable<DailyWordSet> {
    return this.http.patch<DailyWordSet>(`${this.base}/${setId}/complete`, {});
  }
}

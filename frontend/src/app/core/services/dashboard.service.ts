import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { Dashboard } from '../models/dashboard.model';

@Injectable({ providedIn: 'root' })
export class DashboardService {
  private readonly base = `${environment.apiUrl}/dashboard`;

  constructor(private http: HttpClient) {}

  getDashboard(): Observable<Dashboard> {
    return this.http.get<Dashboard>(this.base);
  }

  getActivity(): Observable<{ date: string; wordsStudied: number }[]> {
    return this.http.get<{ date: string; wordsStudied: number }[]>(`${this.base}/activity`);
  }
}

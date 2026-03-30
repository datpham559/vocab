import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';

export interface ActivityLogEntry {
  id: number;
  userId: number | null;
  username: string;
  actionType: string;
  description: string;
  ipAddress: string | null;
  createdAt: string;
}

export interface LogPage {
  content: ActivityLogEntry[];
  totalElements: number;
  totalPages: number;
  page: number;
}

@Injectable({ providedIn: 'root' })
export class ActivityLogService {
  constructor(private http: HttpClient) {}

  getAll(page = 0, size = 50, actionType?: string, username?: string): Observable<LogPage> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (actionType) params = params.set('actionType', actionType);
    if (username)   params = params.set('username', username);
    return this.http.get<LogPage>(`${environment.apiUrl}/activity-logs`, { params });
  }

  getMy(): Observable<ActivityLogEntry[]> {
    return this.http.get<ActivityLogEntry[]>(`${environment.apiUrl}/activity-logs/my`);
  }
}

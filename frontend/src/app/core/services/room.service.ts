import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { RoomState } from '../models/room.model';

@Injectable({ providedIn: 'root' })
export class RoomService {
  private readonly base = `${environment.apiUrl}/room`;

  constructor(private http: HttpClient) {}

  createRoom(questionCount: number): Observable<{ code: string }> {
    return this.http.post<{ code: string }>(this.base, { questionCount });
  }

  joinRoom(code: string): Observable<void> {
    return this.http.post<void>(`${this.base}/${code}/join`, {});
  }

  startGame(code: string): Observable<void> {
    return this.http.post<void>(`${this.base}/${code}/start`, {});
  }

  submitAnswer(code: string, selectedIndex: number): Observable<void> {
    return this.http.post<void>(`${this.base}/${code}/answer`, { selectedIndex });
  }

  getState(code: string): Observable<RoomState> {
    return this.http.get<RoomState>(`${this.base}/${code}/state`);
  }
}

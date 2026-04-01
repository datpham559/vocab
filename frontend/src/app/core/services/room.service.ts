import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { RoomState } from '../models/room.model';

@Injectable({ providedIn: 'root' })
export class RoomService {
  private readonly base = `${environment.apiUrl}/room`;

  constructor(private http: HttpClient) {}

  createRoom(body: {
    questionCount?: number;
    quizMode?: string;
    beginnerCount?: number;
    intermediateCount?: number;
    advancedCount?: number;
    beginnerMode?: string;
    intermediateMode?: string;
    advancedMode?: string;
  }): Observable<{ code: string }> {
    return this.http.post<{ code: string }>(this.base, body);
  }

  submitTypedAnswer(code: string, typedWord: string): Observable<{ correct: boolean }> {
    return this.http.post<{ correct: boolean }>(`${this.base}/${code}/answer/typed`, { typedWord });
  }

  joinRoom(code: string): Observable<void> {
    return this.http.post<void>(`${this.base}/${code}/join`, {});
  }

  spectateRoom(code: string): Observable<void> {
    return this.http.post<void>(`${this.base}/${code}/spectate`, {});
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

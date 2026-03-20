import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { environment } from '../../../environments/environment';
import { Word, WordDifficulty, PageResponse } from '../models/word.model';

@Injectable({ providedIn: 'root' })
export class WordService {
  private readonly base = `${environment.apiUrl}/words`;

  constructor(private http: HttpClient) {}

  getWords(page = 0, size = 20, difficulty?: WordDifficulty, category?: string, search?: string, letter?: string): Observable<PageResponse<Word>> {
    let params = new HttpParams().set('page', page).set('size', size);
    if (difficulty) params = params.set('difficulty', difficulty);
    if (category) params = params.set('category', category);
    if (search) params = params.set('search', search);
    if (letter) params = params.set('letter', letter);
    return this.http.get<PageResponse<Word>>(this.base, { params });
  }

  getStats(): Observable<{ total: number; BEGINNER: number; INTERMEDIATE: number; ADVANCED: number }> {
    return this.http.get<any>(`${this.base}/stats`);
  }

  getWordById(id: number): Observable<Word> {
    return this.http.get<Word>(`${this.base}/${id}`);
  }
}

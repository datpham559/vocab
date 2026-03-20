export type WordDifficulty = 'BEGINNER' | 'INTERMEDIATE' | 'ADVANCED';
export type ProgressStatus = 'NEW' | 'LEARNING' | 'REVIEW' | 'MASTERED';

export interface Word {
  id: number;
  word: string;
  pronunciation: string;
  meaningVi: string;
  partOfSpeech: string;
  exampleSentence: string;
  exampleTranslation: string;
  difficulty: WordDifficulty;
  category: string;
  imageUrl?: string;
}

export interface UserWordProgress {
  id: number;
  wordId: number;
  word: Word;
  status: ProgressStatus;
  correctCount: number;
  wrongCount: number;
  lastReviewed: string;
  nextReview: string;
}

export interface PageResponse<T> {
  content: T[];
  totalElements: number;
  totalPages: number;
  size: number;
  number: number;
  first: boolean;
  last: boolean;
}

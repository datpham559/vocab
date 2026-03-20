import { Word } from './word.model';

export interface DailyWordSet {
  id: number;
  studyDate: string;
  completed: boolean;
  wordsStudied: number;
  totalWords: number;
  words: Word[];
  createdAt: string;
}

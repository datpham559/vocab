export interface QuizQuestion {
  wordId: number;
  word: string;
  pronunciation: string;
  options: string[];
  correctIndex: number;
}

export interface QuizResult {
  totalQuestions: number;
  correctAnswers: number;
  score: number;
  details: { wordId: number; word: string; correct: boolean }[];
}

import { QuizQuestion } from './quiz.model';

export interface RoomState {
  code: string;
  status: 'WAITING' | 'COUNTDOWN' | 'ACTIVE' | 'SHOWING_RESULT' | 'DONE';
  hostId: number;
  participants: ParticipantScore[];
  currentQuestion: QuizQuestion | null;
  questionIndex: number;
  totalQuestions: number;
  timeLeft: number;
  correctIndex: number | null;
  myAnswer: number | null;
  myLastEarned: number | null;
  answeredCount: number;
  questionCount: number;
  countdownLeft: number;
  quizMode: string;
  currentQuestionMode: 'CHOICE' | 'TYPE';
  correctMeaning: string | null;
  beginnerCount: number;
  intermediateCount: number;
  advancedCount: number;
  beginnerMode: string;
  intermediateMode: string;
  advancedMode: string;
}

export interface ParticipantScore {
  userId: number;
  name: string;
  score: number;
  host: boolean;
}

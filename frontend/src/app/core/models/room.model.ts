import { QuizQuestion } from './quiz.model';

export interface RoomState {
  code: string;
  status: 'WAITING' | 'ACTIVE' | 'SHOWING_RESULT' | 'DONE';
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
}

export interface ParticipantScore {
  userId: number;
  name: string;
  score: number;
  host: boolean;
}

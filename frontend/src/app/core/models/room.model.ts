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
  spectators: ParticipantScore[];
  spectator: boolean;
}

export interface RoomEvent {
  type: 'CHAT' | 'REACT';
  userId: number;
  username: string;
  text?: string;
  emoji?: string;
  timestamp: number;
  spectator: boolean;
}

export interface ChatMessage {
  userId: number;
  username: string;
  text: string;
  timestamp: number;
  spectator: boolean;
}

export interface ParticipantScore {
  userId: number;
  name: string;
  score: number;
  host: boolean;
}

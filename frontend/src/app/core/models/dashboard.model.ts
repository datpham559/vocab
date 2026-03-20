export interface Dashboard {
  username: string;
  displayName: string;
  streak: number;
  totalWordsLearned: number;
  newCount: number;
  learningCount: number;
  reviewCount: number;
  masteredCount: number;
  todayCompleted: boolean;
  todayWordsStudied: number;
  todayTotalWords: number;
  totalDaysStudied: number;
}

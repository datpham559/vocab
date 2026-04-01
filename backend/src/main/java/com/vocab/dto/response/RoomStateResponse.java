package com.vocab.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
public class RoomStateResponse {
    private String code;
    private String status;
    private Long hostId;
    private List<ParticipantScore> participants;
    private QuizQuestionResponse currentQuestion;
    private int questionIndex;
    private int totalQuestions;
    private int timeLeft;
    private Integer correctIndex;
    private Integer myAnswer;
    private Integer myLastEarned;
    private int answeredCount;
    private int questionCount;
    private int countdownLeft;
    private String quizMode;
    private String currentQuestionMode; // "CHOICE" or "TYPE" for the current question
    private String correctMeaning;      // populated only when currentQuestionMode == "TYPE"
    private int beginnerCount;
    private int intermediateCount;
    private int advancedCount;
    private String beginnerMode;
    private String intermediateMode;
    private String advancedMode;
    private List<ParticipantScore> spectators;
    private boolean spectator;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class ParticipantScore {
        private Long userId;
        private String name;
        private int score;
        private boolean host;
    }
}

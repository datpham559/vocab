package com.vocab.room;

import com.vocab.dto.response.QuizQuestionResponse;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.atomic.AtomicBoolean;

@Getter
@Setter
public class ActiveRoom {
    private final String code;
    private final Long hostId;
    private volatile RoomStatus status = RoomStatus.WAITING;
    private List<QuizQuestionResponse> questions = new ArrayList<>();
    private volatile int currentQuestionIndex = 0;
    private volatile long questionStartTime = 0;
    private final int timePerQuestion = 15;
    private final ConcurrentHashMap<Long, String> participants = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<Long, Integer> scores = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<Long, Integer> currentAnswers = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<Long, Long> answerTimestamps = new ConcurrentHashMap<>();
    private final ConcurrentHashMap<Long, Integer> lastEarned = new ConcurrentHashMap<>();
    private volatile ScheduledFuture<?> timer;
    private final AtomicBoolean questionEnded = new AtomicBoolean(false);
    private volatile int countdownLeft = 0;
    private final LocalDateTime createdAt = LocalDateTime.now();
    private int questionCount = 20;
    private String quizMode = "CHOICE"; // CHOICE | TYPE | MIXED
    private List<String> questionModes = new ArrayList<>(); // per-question: "CHOICE" or "TYPE"
    private int beginnerCount = 0;
    private int intermediateCount = 0;
    private int advancedCount = 0;
    // Per-difficulty question modes (CHOICE / TYPE / MIXED), used when global quizMode = MIXED
    private String beginnerMode = "MIXED";
    private String intermediateMode = "MIXED";
    private String advancedMode = "MIXED";

    public ActiveRoom(String code, Long hostId) {
        this.code = code;
        this.hostId = hostId;
    }

    public int getTimeLeft() {
        if (status != RoomStatus.ACTIVE) return 0;
        long elapsed = (System.currentTimeMillis() - questionStartTime) / 1000;
        return (int) Math.max(0, timePerQuestion - elapsed);
    }
}

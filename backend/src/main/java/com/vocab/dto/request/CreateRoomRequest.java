package com.vocab.dto.request;

import lombok.Data;

@Data
public class CreateRoomRequest {
    private int questionCount = 20;
    private String quizMode = "CHOICE"; // CHOICE | TYPE | MIXED
    // Custom difficulty counts (null = use default ratio)
    private Integer beginnerCount;
    private Integer intermediateCount;
    private Integer advancedCount;
    // Per-difficulty question mode — only used when quizMode=MIXED and custom config
    // Values: "CHOICE" | "TYPE" | "MIXED" (null defaults to "MIXED")
    private String beginnerMode;
    private String intermediateMode;
    private String advancedMode;
}

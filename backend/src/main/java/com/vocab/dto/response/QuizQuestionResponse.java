package com.vocab.dto.response;

import lombok.Builder;
import lombok.Data;
import java.util.List;

@Data
@Builder
public class QuizQuestionResponse {
    private Long wordId;
    private String word;
    private String pronunciation;
    private List<String> options;    // 4 options including correct answer
    private int correctIndex;        // index of correct answer in options list
}

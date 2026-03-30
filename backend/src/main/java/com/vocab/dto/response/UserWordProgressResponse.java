package com.vocab.dto.response;

import com.vocab.entity.UserWordProgress;
import com.vocab.entity.enums.ProgressStatus;
import lombok.Builder;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
public class UserWordProgressResponse {
    private Long id;
    private Long wordId;
    private WordResponse word;
    private ProgressStatus status;
    private Integer correctCount;
    private Integer wrongCount;
    private LocalDateTime lastReviewed;
    private LocalDate nextReview;
    private Boolean bookmarked;

    public static UserWordProgressResponse from(UserWordProgress p) {
        return UserWordProgressResponse.builder()
            .id(p.getId())
            .wordId(p.getWord().getId())
            .word(WordResponse.from(p.getWord()))
            .status(p.getStatus())
            .correctCount(p.getCorrectCount())
            .wrongCount(p.getWrongCount())
            .lastReviewed(p.getLastReviewed())
            .nextReview(p.getNextReview())
            .bookmarked(p.getBookmarked() != null && p.getBookmarked())
            .build();
    }
}

package com.vocab.dto.response;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DashboardResponse {
    private String username;
    private String displayName;
    private Integer streak;
    private Integer totalWordsLearned;
    private Long newCount;
    private Long learningCount;
    private Long reviewCount;
    private Long masteredCount;
    private Boolean todayCompleted;
    private Integer todayWordsStudied;
    private Integer todayTotalWords;
    private Long totalDaysStudied;
}

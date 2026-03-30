package com.vocab.dto.response;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class LeaderboardEntry {
    private int rank;
    private Long userId;
    private String username;
    private String displayName;
    private int streak;
    private int totalWordsLearned;
}

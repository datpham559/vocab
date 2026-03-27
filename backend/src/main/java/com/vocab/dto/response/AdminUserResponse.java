package com.vocab.dto.response;

import com.vocab.entity.User;
import lombok.Builder;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@Builder
public class AdminUserResponse {
    private Long id;
    private String username;
    private String email;
    private String displayName;
    private String role;
    private Integer streak;
    private Integer totalWordsLearned;
    private LocalDate lastStudyDate;
    private LocalDateTime createdAt;

    public static AdminUserResponse from(User user) {
        return AdminUserResponse.builder()
            .id(user.getId())
            .username(user.getUsername())
            .email(user.getEmail())
            .displayName(user.getDisplayName())
            .role(user.getRole())
            .streak(user.getStreak())
            .totalWordsLearned(user.getTotalWordsLearned())
            .lastStudyDate(user.getLastStudyDate())
            .createdAt(user.getCreatedAt())
            .build();
    }
}

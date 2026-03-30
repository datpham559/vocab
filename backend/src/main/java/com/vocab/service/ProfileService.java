package com.vocab.service;

import com.vocab.dto.request.UpdateProfileRequest;
import com.vocab.dto.response.ProfileResponse;
import com.vocab.entity.User;
import com.vocab.entity.enums.ProgressStatus;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.DailyWordSetRepository;
import com.vocab.repository.UserRepository;
import com.vocab.repository.UserWordProgressRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class ProfileService {

    private final UserRepository userRepository;
    private final UserWordProgressRepository progressRepository;
    private final DailyWordSetRepository dailyWordSetRepository;
    private final PasswordEncoder passwordEncoder;

    public ProfileResponse getProfile(Long userId) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        long newCount       = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.NEW);
        long learningCount  = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.LEARNING);
        long reviewCount    = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.REVIEW);
        long masteredCount  = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.MASTERED);
        long totalDaysStudied = dailyWordSetRepository.countByUserIdAndCompletedTrue(userId);

        return ProfileResponse.builder()
            .userId(user.getId())
            .username(user.getUsername())
            .email(user.getEmail())
            .displayName(user.getDisplayName())
            .role(user.getRole())
            .streak(user.getStreak())
            .totalWordsLearned(user.getTotalWordsLearned())
            .createdAt(user.getCreatedAt().toLocalDate().toString())
            .newCount(newCount)
            .learningCount(learningCount)
            .reviewCount(reviewCount)
            .masteredCount(masteredCount)
            .totalDaysStudied(totalDaysStudied)
            .build();
    }

    @Transactional
    public ProfileResponse updateProfile(Long userId, UpdateProfileRequest request) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        if (request.getDisplayName() != null && !request.getDisplayName().isBlank()) {
            user.setDisplayName(request.getDisplayName().trim());
        }

        if (request.getNewPassword() != null && !request.getNewPassword().isBlank()) {
            if (request.getCurrentPassword() == null ||
                !passwordEncoder.matches(request.getCurrentPassword(), user.getPassword())) {
                throw new IllegalArgumentException("Mật khẩu hiện tại không đúng");
            }
            user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        }

        userRepository.save(user);
        return getProfile(userId);
    }
}

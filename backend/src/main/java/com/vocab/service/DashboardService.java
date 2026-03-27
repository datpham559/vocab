package com.vocab.service;

import com.vocab.dto.response.ActivityDay;
import com.vocab.dto.response.DashboardResponse;
import com.vocab.entity.DailyWordSet;
import com.vocab.entity.User;
import com.vocab.entity.enums.ProgressStatus;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.DailyWordSetRepository;
import com.vocab.repository.UserRepository;
import com.vocab.repository.UserWordProgressRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final UserRepository userRepository;
    private final UserWordProgressRepository progressRepository;
    private final DailyWordSetRepository dailyWordSetRepository;

    public DashboardResponse getDashboard(Long userId) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        long newCount = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.NEW);
        long learningCount = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.LEARNING);
        long reviewCount = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.REVIEW);
        long masteredCount = progressRepository.countByUserIdAndStatus(userId, ProgressStatus.MASTERED);
        long totalDaysStudied = dailyWordSetRepository.countByUserIdAndCompletedTrue(userId);

        Optional<DailyWordSet> todaySet = dailyWordSetRepository
            .findByUserIdAndStudyDate(userId, LocalDate.now());

        return DashboardResponse.builder()
            .username(user.getUsername())
            .displayName(user.getDisplayName())
            .streak(user.getStreak())
            .totalWordsLearned(user.getTotalWordsLearned())
            .newCount(newCount)
            .learningCount(learningCount)
            .reviewCount(reviewCount)
            .masteredCount(masteredCount)
            .todayCompleted(todaySet.map(DailyWordSet::getCompleted).orElse(false))
            .todayWordsStudied(todaySet.map(DailyWordSet::getWordsStudied).orElse(0))
            .todayTotalWords(todaySet.map(s -> s.getWords().size()).orElse(0))
            .totalDaysStudied(totalDaysStudied)
            .build();
    }

    public List<ActivityDay> getActivity(Long userId) {
        LocalDate today = LocalDate.now();
        LocalDate from = today.minusDays(364);
        return dailyWordSetRepository.findByUserIdAndStudyDateBetween(userId, from, today)
            .stream()
            .filter(s -> s.getWordsStudied() > 0)
            .map(s -> new ActivityDay(s.getStudyDate().toString(), s.getWordsStudied()))
            .collect(Collectors.toList());
    }
}

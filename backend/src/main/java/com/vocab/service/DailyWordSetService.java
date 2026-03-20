package com.vocab.service;

import com.vocab.dto.response.DailyWordSetResponse;
import com.vocab.entity.DailyWordSet;
import com.vocab.entity.User;
import com.vocab.entity.UserWordProgress;
import com.vocab.entity.Word;
import com.vocab.entity.enums.ProgressStatus;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.DailyWordSetRepository;
import com.vocab.repository.UserRepository;
import com.vocab.repository.UserWordProgressRepository;
import com.vocab.repository.WordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class DailyWordSetService {

    private static final int DAILY_WORD_COUNT = 10;

    private final DailyWordSetRepository dailyWordSetRepository;
    private final UserRepository userRepository;
    private final WordRepository wordRepository;
    private final UserWordProgressRepository progressRepository;

    @Transactional
    public DailyWordSetResponse getTodaySet(Long userId) {
        LocalDate today = LocalDate.now();

        return dailyWordSetRepository.findByUserIdAndStudyDate(userId, today)
            .map(DailyWordSetResponse::from)
            .orElseGet(() -> DailyWordSetResponse.from(createTodaySet(userId, today)));
    }

    private DailyWordSet createTodaySet(Long userId, LocalDate today) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        List<Word> selectedWords = new ArrayList<>();

        // Priority 1: words due for review
        List<UserWordProgress> dueReviews = progressRepository.findDueForReview(userId, today);
        for (UserWordProgress p : dueReviews) {
            if (selectedWords.size() >= DAILY_WORD_COUNT) break;
            selectedWords.add(p.getWord());
        }

        // Priority 2: fill remaining with new words
        if (selectedWords.size() < DAILY_WORD_COUNT) {
            int remaining = DAILY_WORD_COUNT - selectedWords.size();
            List<Word> newWords = wordRepository.findNewWordsForUser(userId, remaining);
            selectedWords.addAll(newWords);
        }

        // If still not enough, pick any remaining words not already selected
        if (selectedWords.size() < DAILY_WORD_COUNT) {
            int remaining = DAILY_WORD_COUNT - selectedWords.size();
            List<Long> excludeIds = selectedWords.stream().map(Word::getId).toList();
            List<Word> extraWords = wordRepository.findAll().stream()
                .filter(w -> !excludeIds.contains(w.getId()))
                .limit(remaining)
                .toList();
            selectedWords.addAll(extraWords);
        }

        DailyWordSet set = DailyWordSet.builder()
            .user(user)
            .studyDate(today)
            .words(selectedWords)
            .build();

        // Initialize progress records for new words
        for (Word word : selectedWords) {
            progressRepository.findByUserIdAndWordId(userId, word.getId())
                .orElseGet(() -> progressRepository.save(
                    com.vocab.entity.UserWordProgress.builder()
                        .user(user).word(word).status(ProgressStatus.NEW).build()
                ));
        }

        return dailyWordSetRepository.save(set);
    }

    @Transactional
    public DailyWordSetResponse markCompleted(Long setId, Long userId) {
        DailyWordSet set = dailyWordSetRepository.findById(setId)
            .orElseThrow(() -> new ResourceNotFoundException("Daily word set not found"));

        if (!set.getUser().getId().equals(userId)) {
            throw new ResourceNotFoundException("Daily word set not found");
        }

        set.setCompleted(true);
        set.setWordsStudied(set.getWords().size());

        // Update user streak
        User user = set.getUser();
        LocalDate today = LocalDate.now();
        if (user.getLastStudyDate() == null || user.getLastStudyDate().isBefore(today.minusDays(1))) {
            user.setStreak(1);
        } else if (user.getLastStudyDate().equals(today.minusDays(1))) {
            user.setStreak(user.getStreak() + 1);
        }
        user.setLastStudyDate(today);
        userRepository.save(user);

        return DailyWordSetResponse.from(dailyWordSetRepository.save(set));
    }
}

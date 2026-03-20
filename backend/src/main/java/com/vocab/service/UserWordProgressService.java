package com.vocab.service;

import com.vocab.dto.request.ProgressUpdateRequest;
import com.vocab.dto.response.UserWordProgressResponse;
import com.vocab.entity.User;
import com.vocab.entity.UserWordProgress;
import com.vocab.entity.Word;
import com.vocab.entity.enums.ProgressStatus;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.UserRepository;
import com.vocab.repository.UserWordProgressRepository;
import com.vocab.repository.WordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserWordProgressService {

    private final UserWordProgressRepository progressRepository;
    private final UserRepository userRepository;
    private final WordRepository wordRepository;

    public List<UserWordProgressResponse> getUserProgress(Long userId) {
        return progressRepository.findByUserId(userId)
            .stream().map(UserWordProgressResponse::from).collect(Collectors.toList());
    }

    @Transactional
    public UserWordProgressResponse updateProgress(Long userId, Long wordId, ProgressUpdateRequest request) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        Word word = wordRepository.findById(wordId)
            .orElseThrow(() -> new ResourceNotFoundException("Word not found"));

        UserWordProgress progress = progressRepository.findByUserIdAndWordId(userId, wordId)
            .orElseGet(() -> UserWordProgress.builder().user(user).word(word).build());

        if (request.getCorrect()) {
            progress.setCorrectCount(progress.getCorrectCount() + 1);
            advanceStatus(progress);
        } else {
            progress.setWrongCount(progress.getWrongCount() + 1);
            regressStatus(progress);
        }

        progress.setLastReviewed(LocalDateTime.now());
        return UserWordProgressResponse.from(progressRepository.save(progress));
    }

    private void advanceStatus(UserWordProgress progress) {
        LocalDate today = LocalDate.now();
        switch (progress.getStatus()) {
            case NEW -> {
                progress.setStatus(ProgressStatus.LEARNING);
                progress.setNextReview(today);
            }
            case LEARNING -> {
                progress.setStatus(ProgressStatus.REVIEW);
                progress.setNextReview(today);
            }
            case REVIEW -> {
                progress.setStatus(ProgressStatus.MASTERED);
                progress.setNextReview(today);
            }
            case MASTERED -> progress.setNextReview(today.plusDays(14));
        }
    }

    private void regressStatus(UserWordProgress progress) {
        LocalDate today = LocalDate.now();
        switch (progress.getStatus()) {
            case MASTERED -> {
                progress.setStatus(ProgressStatus.REVIEW);
                progress.setNextReview(today.plusDays(3));
            }
            case REVIEW -> {
                progress.setStatus(ProgressStatus.LEARNING);
                progress.setNextReview(today.plusDays(1));
            }
            default -> progress.setNextReview(today.plusDays(1));
        }
    }

    @Transactional
    public UserWordProgress getOrCreateProgress(User user, Word word) {
        return progressRepository.findByUserIdAndWordId(user.getId(), word.getId())
            .orElseGet(() -> progressRepository.save(
                UserWordProgress.builder().user(user).word(word).build()
            ));
    }
}

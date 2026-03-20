package com.vocab.service;

import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.dto.response.WordResponse;
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
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class StudyService {

    private final UserRepository userRepository;
    private final WordRepository wordRepository;
    private final UserWordProgressRepository progressRepository;
    private final QuizService quizService;

    @Transactional
    public List<WordResponse> getStudySession(Long userId, int count) {
        User user = userRepository.findById(userId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));

        LocalDate today = LocalDate.now();
        List<Word> words = new ArrayList<>();

        // Priority 1: words due for review
        List<UserWordProgress> dueReviews = progressRepository.findDueForReview(userId, today);
        for (UserWordProgress p : dueReviews) {
            if (words.size() >= count) break;
            words.add(p.getWord());
        }

        // Priority 2: new words
        if (words.size() < count) {
            int remaining = count - words.size();
            List<Word> newWords = wordRepository.findNewWordsForUser(userId, remaining);
            words.addAll(newWords);
        }

        // Initialize progress records for new words
        for (Word word : words) {
            progressRepository.findByUserIdAndWordId(userId, word.getId())
                .orElseGet(() -> progressRepository.save(
                    UserWordProgress.builder()
                        .user(user).word(word).status(ProgressStatus.NEW).build()
                ));
        }

        return words.stream().map(WordResponse::from).toList();
    }

    public List<QuizQuestionResponse> getQuizForWords(List<Long> wordIds) {
        List<Word> words = wordRepository.findAllById(wordIds);
        return quizService.generateQuizForWords(words);
    }

    public List<QuizQuestionResponse> getReviewQuiz(Long userId) {
        LocalDate today = LocalDate.now();
        List<UserWordProgress> due = progressRepository.findAllDueForReview(userId, today);
        List<Word> words = due.stream().map(UserWordProgress::getWord).toList();
        return quizService.generateQuizForWords(words);
    }

    public long getReviewCount(Long userId) {
        return progressRepository.countDueForReview(userId, LocalDate.now());
    }
}

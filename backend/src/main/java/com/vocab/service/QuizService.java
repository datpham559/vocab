package com.vocab.service;

import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.entity.DailyWordSet;
import com.vocab.entity.Word;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.DailyWordSetRepository;
import com.vocab.repository.WordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.*;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuizService {

    private final DailyWordSetRepository dailyWordSetRepository;
    private final WordRepository wordRepository;

    public List<QuizQuestionResponse> getTodayQuiz(Long userId) {
        DailyWordSet set = dailyWordSetRepository.findByUserIdAndStudyDate(userId, LocalDate.now())
            .orElseThrow(() -> new ResourceNotFoundException("No daily word set found for today. Please study first."));

        return set.getWords().stream()
            .map(this::buildQuestion)
            .collect(Collectors.toList());
    }

    public List<QuizQuestionResponse> generateQuizForWords(List<Word> words) {
        return words.stream().map(this::buildQuestion).collect(Collectors.toList());
    }

    public QuizQuestionResponse buildQuestion(Word word) {
        // Get 3 distractors of similar difficulty using SQL Server NEWID()
        List<Word> distractors = wordRepository.findDistractors(
            word.getDifficulty().name(), word.getId(), 5
        );

        // If not enough same difficulty, get any other words
        if (distractors.size() < 3) {
            List<Long> excludeIds = new ArrayList<>();
            excludeIds.add(word.getId());
            distractors.forEach(d -> excludeIds.add(d.getId()));

            List<Word> extra = wordRepository.findAll().stream()
                .filter(w -> !excludeIds.contains(w.getId()))
                .limit(3 - distractors.size())
                .toList();
            distractors = new ArrayList<>(distractors);
            distractors.addAll(extra);
        }

        List<String> options = new ArrayList<>();
        options.add(word.getMeaningVi()); // correct answer

        distractors.stream()
            .limit(3)
            .forEach(d -> options.add(d.getMeaningVi()));

        Collections.shuffle(options);
        int correctIndex = options.indexOf(word.getMeaningVi());

        return QuizQuestionResponse.builder()
            .wordId(word.getId())
            .word(word.getWord())
            .pronunciation(word.getPronunciation())
            .options(options)
            .correctIndex(correctIndex)
            .build();
    }
}

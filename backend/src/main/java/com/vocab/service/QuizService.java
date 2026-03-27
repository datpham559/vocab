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
        List<Word> distractors = new ArrayList<>();

        // Priority 1: same part of speech (prevents bypass by POS recognition)
        String pos = word.getPartOfSpeech();
        if (pos != null && !pos.isBlank()) {
            distractors = new ArrayList<>(wordRepository.findDistractorsByPos(pos, word.getId(), 5));
        }

        // Priority 2: same difficulty to fill remaining slots
        if (distractors.size() < 3) {
            List<Long> excludeIds = new ArrayList<>();
            excludeIds.add(word.getId());
            distractors.forEach(d -> excludeIds.add(d.getId()));
            List<Word> byDiff = wordRepository.findDistractors(word.getDifficulty().name(), word.getId(), 5);
            byDiff.stream()
                .filter(w -> !excludeIds.contains(w.getId()))
                .limit(3 - distractors.size())
                .forEach(distractors::add);
        }

        // Fallback: any other word
        if (distractors.size() < 3) {
            List<Long> excludeIds = new ArrayList<>();
            excludeIds.add(word.getId());
            distractors.forEach(d -> excludeIds.add(d.getId()));
            wordRepository.findAll().stream()
                .filter(w -> !excludeIds.contains(w.getId()))
                .limit(3 - distractors.size())
                .forEach(distractors::add);
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
            .partOfSpeech(word.getPartOfSpeech())
            .options(options)
            .correctIndex(correctIndex)
            .difficulty(word.getDifficulty().name())
            .build();
    }
}

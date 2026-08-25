package com.vocab.service;

import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.entity.DailyWordSet;
import com.vocab.entity.Word;
import com.vocab.entity.enums.WordDifficulty;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.DailyWordSetRepository;
import com.vocab.repository.WordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.time.LocalDate;
import java.util.*;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Supplier;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class QuizService {

    private final DailyWordSetRepository dailyWordSetRepository;
    private final WordRepository wordRepository;

    public List<QuizQuestionResponse> getTodayQuiz(Long userId) {
        DailyWordSet set = dailyWordSetRepository.findByUserIdAndStudyDate(userId, LocalDate.now())
            .orElseThrow(() -> new ResourceNotFoundException("No daily word set found for today. Please study first."));

        return generateQuizForWords(new ArrayList<>(set.getWords()));
    }

    /**
     * Builds quiz questions for a batch of words, fetching each distinct part-of-speech/difficulty
     * distractor pool from the DB only ONCE for the whole batch (instead of per question) and
     * sampling randomly in memory. Avoids N+1 "ORDER BY NEWID()" round trips for large question sets.
     */
    public List<QuizQuestionResponse> generateQuizForWords(List<Word> words) {
        Map<String, List<Word>> posPools = new HashMap<>();
        Map<WordDifficulty, List<Word>> difficultyPools = new HashMap<>();

        for (Word w : words) {
            String pos = w.getPartOfSpeech();
            if (pos != null && !pos.isBlank()) {
                posPools.computeIfAbsent(pos, wordRepository::findAllByPartOfSpeechIgnoreCase);
            }
            difficultyPools.computeIfAbsent(w.getDifficulty(), wordRepository::findAllByDifficulty);
        }

        // Full-table fallback, loaded at most once per batch and only if actually needed
        // (e.g. a word whose POS/difficulty pools are too small to fill 3 distractors).
        AtomicReference<List<Word>> allWordsCache = new AtomicReference<>();
        Supplier<List<Word>> allWordsSupplier = () ->
            allWordsCache.updateAndGet(cur -> cur != null ? cur : wordRepository.findAll());

        return words.stream()
            .map(w -> buildQuestion(w, posPools, difficultyPools, allWordsSupplier))
            .collect(Collectors.toList());
    }

    /** Builds a single question, sampling distractors from in-memory pools instead of hitting the DB. */
    private QuizQuestionResponse buildQuestion(Word word,
                                                Map<String, List<Word>> posPools,
                                                Map<WordDifficulty, List<Word>> difficultyPools,
                                                Supplier<List<Word>> allWordsSupplier) {
        List<Word> distractors = new ArrayList<>();
        Set<Long> usedIds = new HashSet<>();
        usedIds.add(word.getId());

        // Priority 1: same part of speech (prevents bypass by POS recognition)
        String pos = word.getPartOfSpeech();
        if (pos != null && !pos.isBlank()) {
            fillDistractors(posPools.getOrDefault(pos, List.of()), usedIds, distractors, 3);
        }

        // Priority 2: same difficulty to fill remaining slots
        if (distractors.size() < 3) {
            fillDistractors(difficultyPools.getOrDefault(word.getDifficulty(), List.of()),
                usedIds, distractors, 3 - distractors.size());
        }

        // Fallback: any other word
        if (distractors.size() < 3) {
            fillDistractors(allWordsSupplier.get(), usedIds, distractors, 3 - distractors.size());
        }

        List<String> options = new ArrayList<>();
        options.add(word.getMeaningVi()); // correct answer
        distractors.forEach(d -> options.add(d.getMeaningVi()));

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

    /** Picks up to {@code needed} random words from {@code pool} not already in {@code usedIds}. */
    private void fillDistractors(List<Word> pool, Set<Long> usedIds, List<Word> distractors, int needed) {
        if (needed <= 0 || pool.isEmpty()) return;
        List<Word> shuffled = new ArrayList<>(pool);
        Collections.shuffle(shuffled);
        int added = 0;
        for (Word w : shuffled) {
            if (added >= needed) break;
            if (usedIds.add(w.getId())) {
                distractors.add(w);
                added++;
            }
        }
    }
}

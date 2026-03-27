package com.vocab.controller;

import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.entity.Word;
import com.vocab.repository.WordRepository;
import com.vocab.service.QuizService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/exam")
@RequiredArgsConstructor
public class ExamController {

    private final WordRepository wordRepository;
    private final QuizService quizService;

    @GetMapping("/questions")
    public ResponseEntity<List<QuizQuestionResponse>> getExamQuestions(
            @org.springframework.web.bind.annotation.RequestParam(defaultValue = "40") int count) {
        // 40% BEGINNER, 40% INTERMEDIATE, 20% ADVANCED
        int bCount = (int) Math.round(count * 0.4);
        int aCount = (int) Math.round(count * 0.2);
        int iCount = count - bCount - aCount;

        List<Word> all = new ArrayList<>();
        all.addAll(wordRepository.findRandomByDifficulty("BEGINNER",     bCount));
        all.addAll(wordRepository.findRandomByDifficulty("INTERMEDIATE", iCount));
        all.addAll(wordRepository.findRandomByDifficulty("ADVANCED",     aCount));
        Collections.shuffle(all);

        List<QuizQuestionResponse> questions = all.stream()
            .map(quizService::buildQuestion)
            .toList();

        return ResponseEntity.ok(questions);
    }
}

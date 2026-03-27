package com.vocab.controller;

import com.vocab.dto.response.CategoryInfo;
import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.dto.response.WordResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.StudyService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/study")
@RequiredArgsConstructor
public class StudyController {

    private final StudyService studyService;

    @GetMapping("/categories")
    public ResponseEntity<List<CategoryInfo>> getCategories() {
        return ResponseEntity.ok(studyService.getCategories());
    }

    @GetMapping("/session")
    public ResponseEntity<List<WordResponse>> getSession(
            @RequestParam(defaultValue = "20") int count,
            @RequestParam(required = false) String category,
            @AuthenticationPrincipal UserPrincipal principal) {
        if (category != null && !category.isBlank()) {
            return ResponseEntity.ok(studyService.getStudySessionByCategory(principal.getId(), category, count));
        }
        return ResponseEntity.ok(studyService.getStudySession(principal.getId(), count));
    }

    @GetMapping("/quiz")
    public ResponseEntity<List<QuizQuestionResponse>> getQuizForWords(
            @RequestParam List<Long> wordIds,
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(studyService.getQuizForWords(wordIds));
    }

    @GetMapping("/review")
    public ResponseEntity<List<QuizQuestionResponse>> getReviewQuiz(
            @RequestParam(defaultValue = "20") int count,
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(studyService.getReviewQuiz(principal.getId(), count));
    }

    @GetMapping("/review/count")
    public ResponseEntity<Map<String, Long>> getReviewCount(
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(Map.of("count", studyService.getLearnedCount(principal.getId())));
    }
}

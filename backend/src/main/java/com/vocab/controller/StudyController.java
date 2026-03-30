package com.vocab.controller;

import com.vocab.dto.response.CategoryInfo;
import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.dto.response.WordResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.ActivityLogService;
import com.vocab.service.StudyService;
import com.vocab.util.IpUtils;
import jakarta.servlet.http.HttpServletRequest;
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
    private final ActivityLogService activityLogService;

    @GetMapping("/categories")
    public ResponseEntity<List<CategoryInfo>> getCategories() {
        return ResponseEntity.ok(studyService.getCategories());
    }

    @GetMapping("/session")
    public ResponseEntity<List<WordResponse>> getSession(
            @RequestParam(defaultValue = "20") int count,
            @RequestParam(required = false) String category,
            @AuthenticationPrincipal UserPrincipal principal,
            HttpServletRequest request) {
        String ip = IpUtils.getIp(request);
        List<WordResponse> words;
        if (category != null && !category.isBlank()) {
            words = studyService.getStudySessionByCategory(principal.getId(), category, count);
            activityLogService.log(principal.getId(), principal.getUsername(), "STUDY_STARTED",
                "Bắt đầu học " + words.size() + " từ — chủ đề: " + category, ip);
        } else {
            words = studyService.getStudySession(principal.getId(), count);
            activityLogService.log(principal.getId(), principal.getUsername(), "STUDY_STARTED",
                "Bắt đầu học " + words.size() + " từ", ip);
        }
        return ResponseEntity.ok(words);
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
            @AuthenticationPrincipal UserPrincipal principal,
            HttpServletRequest request) {
        List<QuizQuestionResponse> questions = studyService.getReviewQuiz(principal.getId(), count);
        activityLogService.log(principal.getId(), principal.getUsername(), "REVIEW_STARTED",
            "Bắt đầu ôn tập " + questions.size() + " từ", IpUtils.getIp(request));
        return ResponseEntity.ok(questions);
    }

    @GetMapping("/bookmarks")
    public ResponseEntity<List<WordResponse>> getBookmarksSession(
            @AuthenticationPrincipal UserPrincipal principal,
            HttpServletRequest request) {
        List<WordResponse> words = studyService.getBookmarksSession(principal.getId());
        if (!words.isEmpty()) {
            activityLogService.log(principal.getId(), principal.getUsername(), "STUDY_STARTED",
                "Học " + words.size() + " từ yêu thích", IpUtils.getIp(request));
        }
        return ResponseEntity.ok(words);
    }

    @GetMapping("/review/count")
    public ResponseEntity<Map<String, Long>> getReviewCount(
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(Map.of("count", studyService.getLearnedCount(principal.getId())));
    }
}

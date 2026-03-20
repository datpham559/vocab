package com.vocab.controller;

import com.vocab.dto.response.QuizQuestionResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.QuizService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/quiz")
@RequiredArgsConstructor
public class QuizController {

    private final QuizService quizService;

    @GetMapping("/today")
    public ResponseEntity<List<QuizQuestionResponse>> getTodayQuiz(
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(quizService.getTodayQuiz(principal.getId()));
    }
}

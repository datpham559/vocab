package com.vocab.controller;

import com.vocab.dto.request.ProgressUpdateRequest;
import com.vocab.dto.response.UserWordProgressResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.UserWordProgressService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/progress")
@RequiredArgsConstructor
public class ProgressController {

    private final UserWordProgressService progressService;

    @GetMapping
    public ResponseEntity<List<UserWordProgressResponse>> getMyProgress(
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(progressService.getUserProgress(principal.getId()));
    }

    @PatchMapping("/{wordId}")
    public ResponseEntity<UserWordProgressResponse> updateProgress(
            @PathVariable Long wordId,
            @Valid @RequestBody ProgressUpdateRequest request,
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(progressService.updateProgress(principal.getId(), wordId, request));
    }
}

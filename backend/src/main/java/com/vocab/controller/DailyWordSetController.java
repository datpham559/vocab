package com.vocab.controller;

import com.vocab.dto.response.DailyWordSetResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.DailyWordSetService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/daily-word-sets")
@RequiredArgsConstructor
public class DailyWordSetController {

    private final DailyWordSetService dailyWordSetService;

    @GetMapping("/today")
    public ResponseEntity<DailyWordSetResponse> getTodaySet(
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(dailyWordSetService.getTodaySet(principal.getId()));
    }

    @PatchMapping("/{id}/complete")
    public ResponseEntity<DailyWordSetResponse> markCompleted(
            @PathVariable Long id,
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(dailyWordSetService.markCompleted(id, principal.getId()));
    }
}

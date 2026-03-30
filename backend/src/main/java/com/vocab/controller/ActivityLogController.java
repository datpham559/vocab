package com.vocab.controller;

import com.vocab.dto.response.ActivityLogResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.ActivityLogService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/activity-logs")
@RequiredArgsConstructor
public class ActivityLogController {

    private final ActivityLogService activityLogService;

    @GetMapping
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Map<String, Object>> getAll(
            @RequestParam(defaultValue = "0")   int page,
            @RequestParam(defaultValue = "50")  int size,
            @RequestParam(required = false) String actionType,
            @RequestParam(required = false) String username) {

        Page<ActivityLogResponse> result = activityLogService
            .getAll(page, size, actionType, username)
            .map(ActivityLogResponse::from);

        return ResponseEntity.ok(Map.of(
            "content",       result.getContent(),
            "totalElements", result.getTotalElements(),
            "totalPages",    result.getTotalPages(),
            "page",          result.getNumber()
        ));
    }

    @GetMapping("/my")
    public ResponseEntity<List<ActivityLogResponse>> getMy(
            @AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(
            activityLogService.getByUser(principal.getId())
                .stream().map(ActivityLogResponse::from).toList()
        );
    }
}

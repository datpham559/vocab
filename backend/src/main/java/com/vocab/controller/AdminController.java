package com.vocab.controller;

import com.vocab.dto.response.AdminUserResponse;
import com.vocab.entity.enums.WordDifficulty;
import com.vocab.repository.WordRepository;
import com.vocab.security.UserPrincipal;
import com.vocab.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;
    private final WordRepository wordRepository;

    @GetMapping("/words/stats")
    public ResponseEntity<Map<String, Object>> getWordStats() {
        Map<String, Object> stats = new LinkedHashMap<>();
        stats.put("total", wordRepository.count());
        stats.put("beginner",     wordRepository.countByDifficulty(WordDifficulty.BEGINNER));
        stats.put("intermediate", wordRepository.countByDifficulty(WordDifficulty.INTERMEDIATE));
        stats.put("advanced",     wordRepository.countByDifficulty(WordDifficulty.ADVANCED));
        Map<String, Long> byCategory = new LinkedHashMap<>();
        wordRepository.countByCategory().forEach(row -> byCategory.put((String) row[0], (Long) row[1]));
        stats.put("byCategory", byCategory);
        return ResponseEntity.ok(stats);
    }

    @GetMapping("/users")
    public ResponseEntity<List<AdminUserResponse>> getAllUsers() {
        return ResponseEntity.ok(adminService.getAllUsers());
    }

    @PatchMapping("/users/{id}/role")
    public ResponseEntity<AdminUserResponse> updateRole(
            @PathVariable Long id,
            @RequestBody Map<String, String> body) {
        String role = body.get("role");
        return ResponseEntity.ok(adminService.updateRole(id, role));
    }

    @DeleteMapping("/users/{id}")
    public ResponseEntity<Void> deleteUser(
            @PathVariable Long id,
            @AuthenticationPrincipal UserPrincipal principal) {
        adminService.deleteUser(id, principal.getId());
        return ResponseEntity.noContent().build();
    }
}

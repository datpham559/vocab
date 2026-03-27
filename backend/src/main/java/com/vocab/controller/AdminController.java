package com.vocab.controller;

import com.vocab.dto.response.AdminUserResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.AdminService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/admin")
@RequiredArgsConstructor
public class AdminController {

    private final AdminService adminService;

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

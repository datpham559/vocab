package com.vocab.controller;

import com.vocab.dto.request.UpdateProfileRequest;
import com.vocab.dto.response.ProfileResponse;
import com.vocab.security.UserPrincipal;
import com.vocab.service.ActivityLogService;
import com.vocab.service.ProfileService;
import com.vocab.util.IpUtils;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/profile")
@RequiredArgsConstructor
public class ProfileController {

    private final ProfileService profileService;
    private final ActivityLogService activityLogService;

    @GetMapping
    public ResponseEntity<ProfileResponse> getProfile(@AuthenticationPrincipal UserPrincipal principal) {
        return ResponseEntity.ok(profileService.getProfile(principal.getId()));
    }

    @PutMapping
    public ResponseEntity<?> updateProfile(
            @AuthenticationPrincipal UserPrincipal principal,
            @RequestBody UpdateProfileRequest request,
            HttpServletRequest httpRequest) {
        try {
            ProfileResponse updated = profileService.updateProfile(principal.getId(), request);
            String detail = request.getNewPassword() != null && !request.getNewPassword().isBlank()
                ? "Đổi mật khẩu" : "Cập nhật tên: " + updated.getDisplayName();
            activityLogService.log(principal.getId(), principal.getUsername(), "PROFILE_UPDATED", detail,
                IpUtils.getIp(httpRequest));
            return ResponseEntity.ok(updated);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(e.getMessage());
        }
    }
}

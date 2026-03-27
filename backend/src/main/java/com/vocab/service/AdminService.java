package com.vocab.service;

import com.vocab.dto.response.AdminUserResponse;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@RequiredArgsConstructor
public class AdminService {

    private final UserRepository userRepository;

    public List<AdminUserResponse> getAllUsers() {
        return userRepository.findAll().stream()
            .map(AdminUserResponse::from)
            .toList();
    }

    @Transactional
    public AdminUserResponse updateRole(Long userId, String role) {
        var user = userRepository.findById(userId)
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        user.setRole(role);
        return AdminUserResponse.from(userRepository.save(user));
    }

    @Transactional
    public void deleteUser(Long userId, Long requesterId) {
        if (userId.equals(requesterId)) {
            throw new IllegalArgumentException("Cannot delete your own account");
        }
        if (!userRepository.existsById(userId)) {
            throw new ResourceNotFoundException("User not found");
        }
        userRepository.deleteById(userId);
    }
}

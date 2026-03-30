package com.vocab.service;

import com.vocab.entity.ActivityLog;
import com.vocab.repository.ActivityLogRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ActivityLogService {

    private final ActivityLogRepository repository;

    @Async
    public void log(Long userId, String username, String actionType, String description, String ipAddress) {
        repository.save(ActivityLog.builder()
            .userId(userId)
            .username(username)
            .actionType(actionType)
            .description(description)
            .ipAddress(ipAddress)
            .build());
    }

    public Page<ActivityLog> getAll(int page, int size, String actionType, String username) {
        PageRequest pageable = PageRequest.of(page, size);
        if (actionType != null && !actionType.isBlank()) {
            return repository.findByActionTypeOrderByCreatedAtDesc(actionType, pageable);
        }
        if (username != null && !username.isBlank()) {
            return repository.findByUsernameContainingIgnoreCaseOrderByCreatedAtDesc(username, pageable);
        }
        return repository.findAllByOrderByCreatedAtDesc(pageable);
    }

    public List<ActivityLog> getByUser(Long userId) {
        return repository.findByUserIdOrderByCreatedAtDesc(userId);
    }
}

package com.vocab.dto.response;

import com.vocab.entity.ActivityLog;
import lombok.Data;

@Data
public class ActivityLogResponse {
    private Long id;
    private Long userId;
    private String username;
    private String actionType;
    private String description;
    private String ipAddress;
    private String createdAt;

    public static ActivityLogResponse from(ActivityLog log) {
        ActivityLogResponse r = new ActivityLogResponse();
        r.setId(log.getId());
        r.setUserId(log.getUserId());
        r.setUsername(log.getUsername());
        r.setActionType(log.getActionType());
        r.setDescription(log.getDescription());
        r.setIpAddress(log.getIpAddress());
        r.setCreatedAt(log.getCreatedAt().toString());
        return r;
    }
}

package com.vocab.dto.request;

import lombok.Data;

@Data
public class UpdateProfileRequest {
    private String displayName;
    private String currentPassword;
    private String newPassword;
}

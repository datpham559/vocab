package com.vocab.dto.request;

import jakarta.validation.constraints.NotNull;
import lombok.Data;

@Data
public class ProgressUpdateRequest {
    @NotNull
    private Boolean correct;
}

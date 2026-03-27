package com.vocab.dto.request;

import lombok.Data;

@Data
public class CreateRoomRequest {
    private int questionCount = 20;
}

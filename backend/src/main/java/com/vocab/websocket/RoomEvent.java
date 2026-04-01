package com.vocab.websocket;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class RoomEvent {
    private String type;      // "CHAT" | "REACT"
    private Long userId;
    private String username;
    private String text;      // for CHAT
    private String emoji;     // for REACT
    private long timestamp;
    private boolean spectator;
}

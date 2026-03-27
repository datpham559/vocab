package com.vocab.room;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;

@Component
public class RoomStore {
    private final ConcurrentHashMap<String, ActiveRoom> rooms = new ConcurrentHashMap<>();

    public void put(String code, ActiveRoom room) {
        rooms.put(code, room);
    }

    public Optional<ActiveRoom> get(String code) {
        return Optional.ofNullable(rooms.get(code));
    }

    @Scheduled(fixedDelay = 300_000)
    public void cleanup() {
        LocalDateTime cutoff = LocalDateTime.now().minusHours(2);
        rooms.entrySet().removeIf(e -> e.getValue().getCreatedAt().isBefore(cutoff));
    }
}

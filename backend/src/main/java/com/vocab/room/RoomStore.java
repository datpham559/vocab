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
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime staleCutoff = now.minusHours(2);       // safety net for abandoned WAITING/ACTIVE rooms
        LocalDateTime finishedCutoff = now.minusMinutes(5);  // grace period for clients to see final results
        rooms.entrySet().removeIf(e -> {
            ActiveRoom room = e.getValue();
            if (room.getStatus() == RoomStatus.DONE) {
                LocalDateTime finishedAt = room.getFinishedAt();
                return finishedAt == null || finishedAt.isBefore(finishedCutoff);
            }
            return room.getCreatedAt().isBefore(staleCutoff);
        });
    }
}

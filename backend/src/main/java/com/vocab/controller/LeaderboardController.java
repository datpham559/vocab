package com.vocab.controller;

import com.vocab.dto.response.LeaderboardEntry;
import com.vocab.entity.User;
import com.vocab.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/leaderboard")
@RequiredArgsConstructor
public class LeaderboardController {

    private final UserRepository userRepository;

    @GetMapping("/streak")
    public ResponseEntity<List<LeaderboardEntry>> byStreak(
            @RequestParam(defaultValue = "50") int limit) {
        return ResponseEntity.ok(buildBoard(userRepository.findTopByStreak(PageRequest.of(0, limit))));
    }

    @GetMapping("/words")
    public ResponseEntity<List<LeaderboardEntry>> byWords(
            @RequestParam(defaultValue = "50") int limit) {
        return ResponseEntity.ok(buildBoard(userRepository.findTopByWords(PageRequest.of(0, limit))));
    }

    private List<LeaderboardEntry> buildBoard(List<User> users) {
        List<LeaderboardEntry> board = new ArrayList<>();
        int rank = 1;
        for (User u : users) {
            board.add(new LeaderboardEntry(
                rank++,
                u.getId(),
                u.getUsername(),
                u.getDisplayName() != null ? u.getDisplayName() : u.getUsername(),
                u.getStreak(),
                u.getTotalWordsLearned()
            ));
        }
        return board;
    }
}

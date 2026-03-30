package com.vocab.controller;

import com.vocab.dto.response.UserWordProgressResponse;
import com.vocab.entity.User;
import com.vocab.entity.UserWordProgress;
import com.vocab.entity.Word;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.UserRepository;
import com.vocab.repository.UserWordProgressRepository;
import com.vocab.repository.WordRepository;
import com.vocab.security.UserPrincipal;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/bookmarks")
@RequiredArgsConstructor
public class BookmarkController {

    private final UserWordProgressRepository progressRepository;
    private final UserRepository userRepository;
    private final WordRepository wordRepository;

    @GetMapping
    public ResponseEntity<List<UserWordProgressResponse>> getBookmarks(
            @AuthenticationPrincipal UserPrincipal principal) {
        List<UserWordProgressResponse> result = progressRepository
            .findByUserIdAndBookmarkedTrue(principal.getId())
            .stream().map(UserWordProgressResponse::from).toList();
        return ResponseEntity.ok(result);
    }

    @PostMapping("/{wordId}/toggle")
    @Transactional
    public ResponseEntity<Map<String, Boolean>> toggle(
            @PathVariable Long wordId,
            @AuthenticationPrincipal UserPrincipal principal) {

        User user = userRepository.findById(principal.getId())
            .orElseThrow(() -> new ResourceNotFoundException("User not found"));
        Word word = wordRepository.findById(wordId)
            .orElseThrow(() -> new ResourceNotFoundException("Word not found"));

        UserWordProgress progress = progressRepository
            .findByUserIdAndWordId(principal.getId(), wordId)
            .orElseGet(() -> progressRepository.save(
                UserWordProgress.builder().user(user).word(word).build()
            ));

        boolean newState = !Boolean.TRUE.equals(progress.getBookmarked());
        progress.setBookmarked(newState);
        progressRepository.save(progress);

        return ResponseEntity.ok(Map.of("bookmarked", newState));
    }
}

package com.vocab.controller;

import com.vocab.dto.request.CreateWordRequest;
import com.vocab.dto.response.WordLookupResponse;
import com.vocab.dto.response.WordResponse;
import com.vocab.entity.enums.WordDifficulty;
import com.vocab.service.WordService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/words")
@RequiredArgsConstructor
public class WordController {

    private final WordService wordService;

    @GetMapping
    public ResponseEntity<Page<WordResponse>> getAllWords(
            @RequestParam(required = false) WordDifficulty difficulty,
            @RequestParam(required = false) String category,
            @RequestParam(required = false) String search,
            @RequestParam(required = false) String letter,
            @PageableDefault(size = 20) Pageable pageable) {

        if (search != null && !search.isEmpty()) {
            return ResponseEntity.ok(wordService.searchWords(search, category, pageable));
        }
        if (letter != null && !letter.isEmpty()) {
            return ResponseEntity.ok(wordService.getWordsByLetter(letter.toLowerCase(), difficulty, category, pageable));
        }
        return ResponseEntity.ok(wordService.getWords(difficulty, category, pageable));
    }

    @GetMapping("/stats")
    public ResponseEntity<java.util.Map<String, Long>> getStats() {
        java.util.Map<String, Long> stats = new java.util.LinkedHashMap<>();
        stats.put("total", wordService.getTotalCount());
        stats.put("BEGINNER", wordService.getCountByDifficulty(WordDifficulty.BEGINNER));
        stats.put("INTERMEDIATE", wordService.getCountByDifficulty(WordDifficulty.INTERMEDIATE));
        stats.put("ADVANCED", wordService.getCountByDifficulty(WordDifficulty.ADVANCED));
        return ResponseEntity.ok(stats);
    }

    @GetMapping("/lookup")
    public ResponseEntity<WordLookupResponse> lookup(@RequestParam String word) {
        return ResponseEntity.ok(wordService.lookupWord(word));
    }

    @PostMapping
    public ResponseEntity<WordResponse> createWord(@RequestBody CreateWordRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(wordService.createWord(request));
    }

    @GetMapping("/{id}")
    public ResponseEntity<WordResponse> getWordById(@PathVariable Long id) {
        return ResponseEntity.ok(wordService.getWordById(id));
    }
}

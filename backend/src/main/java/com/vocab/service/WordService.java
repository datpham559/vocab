package com.vocab.service;

import com.vocab.dto.response.WordResponse;
import com.vocab.entity.enums.WordDifficulty;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.WordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class WordService {

    private final WordRepository wordRepository;

    public Page<WordResponse> getAllWords(Pageable pageable) {
        return wordRepository.findAll(pageable).map(WordResponse::from);
    }

    public Page<WordResponse> getWordsByDifficulty(WordDifficulty difficulty, Pageable pageable) {
        return wordRepository.findByDifficulty(difficulty, pageable).map(WordResponse::from);
    }

    public Page<WordResponse> getWordsByCategory(String category, Pageable pageable) {
        return wordRepository.findByCategory(category, pageable).map(WordResponse::from);
    }

    public Page<WordResponse> searchWords(String keyword, Pageable pageable) {
        return wordRepository.searchWords(keyword, pageable).map(WordResponse::from);
    }

    public Page<WordResponse> getWordsByLetter(String letter, WordDifficulty difficulty, Pageable pageable) {
        if (difficulty != null) {
            return wordRepository.findByWordStartingWithAndDifficulty(letter, difficulty.name(), pageable).map(WordResponse::from);
        }
        return wordRepository.findByWordStartingWith(letter, pageable).map(WordResponse::from);
    }

    public long getTotalCount() {
        return wordRepository.count();
    }

    public long getCountByDifficulty(WordDifficulty difficulty) {
        return wordRepository.countByDifficulty(difficulty);
    }

    public WordResponse getWordById(Long id) {
        return wordRepository.findById(id)
            .map(WordResponse::from)
            .orElseThrow(() -> new ResourceNotFoundException("Word not found with id: " + id));
    }
}

package com.vocab.dto.response;

import com.vocab.entity.Word;
import com.vocab.entity.enums.WordDifficulty;
import lombok.Builder;
import lombok.Data;
import java.time.LocalDateTime;

@Data
@Builder
public class WordResponse {
    private Long id;
    private String word;
    private String pronunciation;
    private String meaningVi;
    private String partOfSpeech;
    private String exampleSentence;
    private String exampleTranslation;
    private WordDifficulty difficulty;
    private String category;
    private String imageUrl;
    private LocalDateTime createdAt;

    public static WordResponse from(Word word) {
        return WordResponse.builder()
            .id(word.getId())
            .word(word.getWord())
            .pronunciation(word.getPronunciation())
            .meaningVi(word.getMeaningVi())
            .partOfSpeech(word.getPartOfSpeech())
            .exampleSentence(word.getExampleSentence())
            .exampleTranslation(word.getExampleTranslation())
            .difficulty(word.getDifficulty())
            .category(word.getCategory())
            .imageUrl(word.getImageUrl())
            .createdAt(word.getCreatedAt())
            .build();
    }
}

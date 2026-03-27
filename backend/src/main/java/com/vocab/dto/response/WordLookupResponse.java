package com.vocab.dto.response;

import lombok.*;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WordLookupResponse {
    private boolean existsInDb;
    private String word;
    private String pronunciation;
    private String partOfSpeech;
    private String meaningVi;
    private String exampleSentence;
    private String exampleTranslation;
    private String difficulty;
    private String category;
}

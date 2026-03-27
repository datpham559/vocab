package com.vocab.dto.request;

public record CreateWordRequest(
    String word,
    String pronunciation,
    String meaningVi,
    String partOfSpeech,
    String difficulty,
    String category,
    String exampleSentence,
    String exampleTranslation
) {}

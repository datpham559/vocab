package com.vocab.service;

import com.vocab.dto.request.CreateWordRequest;
import com.vocab.dto.response.WordLookupResponse;
import com.vocab.dto.response.WordResponse;
import com.vocab.entity.Word;
import com.vocab.entity.enums.WordDifficulty;
import com.vocab.exception.ResourceNotFoundException;
import com.vocab.repository.WordRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class WordService {

    private final WordRepository wordRepository;
    private final GeminiService geminiService;

    public Page<WordResponse> getWords(WordDifficulty difficulty, String category, Pageable pageable) {
        boolean hasDiff = difficulty != null;
        boolean hasCat  = category != null && !category.isBlank();

        if (hasDiff && hasCat) return wordRepository.findByDifficultyAndCategory(difficulty, category, pageable).map(WordResponse::from);
        if (hasDiff)           return wordRepository.findByDifficulty(difficulty, pageable).map(WordResponse::from);
        if (hasCat)            return wordRepository.findByCategory(category, pageable).map(WordResponse::from);
        return wordRepository.findAll(pageable).map(WordResponse::from);
    }

    public Page<WordResponse> searchWords(String keyword, String category, Pageable pageable) {
        if (category != null && !category.isBlank()) {
            return wordRepository.searchWordsInCategory(keyword, category, pageable).map(WordResponse::from);
        }
        return wordRepository.searchWords(keyword, pageable).map(WordResponse::from);
    }

    public Page<WordResponse> getWordsByLetter(String letter, WordDifficulty difficulty, String category, Pageable pageable) {
        boolean hasDiff = difficulty != null;
        boolean hasCat  = category != null && !category.isBlank();

        if (hasDiff && hasCat) return wordRepository.findByWordStartingWithAndDifficultyAndCategory(letter, difficulty.name(), category, pageable).map(WordResponse::from);
        if (hasDiff)           return wordRepository.findByWordStartingWithAndDifficulty(letter, difficulty.name(), pageable).map(WordResponse::from);
        if (hasCat)            return wordRepository.findByWordStartingWithAndCategory(letter, category, pageable).map(WordResponse::from);
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

    public WordLookupResponse lookupWord(String word) {
        var existing = wordRepository.findByWordIgnoreCase(word.trim());
        if (existing.isPresent()) {
            Word w = existing.get();
            return WordLookupResponse.builder()
                .existsInDb(true)
                .word(w.getWord())
                .pronunciation(w.getPronunciation())
                .partOfSpeech(w.getPartOfSpeech())
                .meaningVi(w.getMeaningVi())
                .exampleSentence(w.getExampleSentence())
                .exampleTranslation(w.getExampleTranslation())
                .difficulty(w.getDifficulty() != null ? w.getDifficulty().name() : null)
                .category(w.getCategory())
                .build();
        }

        // Try external dictionary API
        try {
            String encoded = URLEncoder.encode(word.trim(), StandardCharsets.UTF_8);
            RestTemplate rt = new RestTemplate();
            ResponseEntity<List<Map<String, Object>>> resp = rt.exchange(
                "https://api.dictionaryapi.dev/api/v2/entries/en/" + encoded,
                HttpMethod.GET, null, new ParameterizedTypeReference<>() {});

            List<Map<String, Object>> body = resp.getBody();
            if (body != null && !body.isEmpty()) {
                Map<String, Object> entry = body.get(0);
                String pronunciation = extractPronunciation(entry);
                String partOfSpeech = null;
                String definitionEn = null;
                String exampleEn = null;

                @SuppressWarnings("unchecked")
                List<Map<String, Object>> meanings = (List<Map<String, Object>>) entry.get("meanings");
                if (meanings != null && !meanings.isEmpty()) {
                    // Take partOfSpeech and definition from first meaning
                    Map<String, Object> first = meanings.get(0);
                    partOfSpeech = (String) first.get("partOfSpeech");
                    @SuppressWarnings("unchecked")
                    List<Map<String, Object>> firstDefs = (List<Map<String, Object>>) first.get("definitions");
                    if (firstDefs != null && !firstDefs.isEmpty()) {
                        definitionEn = (String) firstDefs.get(0).get("definition");
                    }
                    // Search ALL meanings + definitions for an example sentence
                    outer:
                    for (Map<String, Object> meaning : meanings) {
                        @SuppressWarnings("unchecked")
                        List<Map<String, Object>> defs = (List<Map<String, Object>>) meaning.get("definitions");
                        if (defs == null) continue;
                        for (Map<String, Object> def : defs) {
                            String ex = (String) def.get("example");
                            if (ex != null && !ex.isBlank()) {
                                exampleEn = ex;
                                break outer;
                            }
                        }
                    }
                }

                String meaningVi = translate(rt, definitionEn);
                String exampleTranslation = translate(rt, exampleEn);

                // Enrich with Gemini: difficulty, category, better translation, example
                GeminiService.GeminiResult ai = geminiService.enrich(
                    word.trim(), partOfSpeech, definitionEn, exampleEn, meaningVi);

                if (ai != null) {
                    if (ai.meaningVi()         != null && !ai.meaningVi().isBlank())         meaningVi = ai.meaningVi();
                    if (ai.exampleSentence()   != null && !ai.exampleSentence().isBlank())   exampleEn = ai.exampleSentence();
                    if (ai.exampleTranslation()!= null && !ai.exampleTranslation().isBlank()) exampleTranslation = ai.exampleTranslation();
                }

                return WordLookupResponse.builder()
                    .existsInDb(false)
                    .word(word.trim().toLowerCase())
                    .pronunciation(pronunciation)
                    .partOfSpeech(partOfSpeech)
                    .meaningVi(meaningVi)
                    .exampleSentence(exampleEn)
                    .exampleTranslation(exampleTranslation)
                    .difficulty(ai != null ? ai.difficulty() : null)
                    .category(ai != null ? ai.category() : null)
                    .build();
            }
        } catch (Exception ignored) {}

        return WordLookupResponse.builder()
            .existsInDb(false)
            .word(word.trim().toLowerCase())
            .build();
    }

    @SuppressWarnings("unchecked")
    private String extractPronunciation(Map<String, Object> entry) {
        String p = (String) entry.get("phonetic");
        if (p != null && !p.isBlank()) return p;
        List<Map<String, Object>> phonetics = (List<Map<String, Object>>) entry.get("phonetics");
        if (phonetics != null) {
            for (Map<String, Object> ph : phonetics) {
                String t = (String) ph.get("text");
                if (t != null && !t.isBlank()) return t;
            }
        }
        return null;
    }

    private String translate(RestTemplate rt, String text) {
        if (text == null || text.isBlank()) return null;
        try {
            String encoded = URLEncoder.encode(text, StandardCharsets.UTF_8);
            @SuppressWarnings("unchecked")
            Map<String, Object> result = rt.getForObject(
                "https://api.mymemory.translated.net/get?q=" + encoded + "&langpair=en|vi",
                Map.class);
            if (result != null) {
                @SuppressWarnings("unchecked")
                Map<String, Object> data = (Map<String, Object>) result.get("responseData");
                if (data != null) return (String) data.get("translatedText");
            }
        } catch (Exception ignored) {}
        return null;
    }

    @Transactional
    public WordResponse createWord(CreateWordRequest req) {
        if (wordRepository.findByWordIgnoreCase(req.word().trim()).isPresent()) {
            throw new IllegalArgumentException("Từ đã tồn tại: " + req.word());
        }
        Word word = Word.builder()
            .word(req.word().trim().toLowerCase())
            .pronunciation(req.pronunciation())
            .meaningVi(req.meaningVi())
            .partOfSpeech(req.partOfSpeech())
            .difficulty(req.difficulty() != null ? WordDifficulty.valueOf(req.difficulty()) : WordDifficulty.BEGINNER)
            .category(req.category())
            .exampleSentence(req.exampleSentence())
            .exampleTranslation(req.exampleTranslation())
            .build();
        return WordResponse.from(wordRepository.save(word));
    }

}

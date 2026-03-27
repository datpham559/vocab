package com.vocab.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class GeminiService {

    private static final String GEMINI_URL =
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=";

    private static final String CATEGORIES =
        "Achievement, Actions, Animals, Body, Business, Character, Clothing, " +
        "Communication, Culture, Descriptive, Education, Emotions, Entertainment, " +
        "Food, General, Health, Home, Language, Nature, People, Places, " +
        "Politics, Shopping, Social, Technology, Thinking, Time, Transport, Travel, Work";

    @Value("${app.gemini.api-key:}")
    private String apiKey;

    private final ObjectMapper mapper = new ObjectMapper();

    public record GeminiResult(
        String difficulty,
        String category,
        String meaningVi,
        String exampleSentence,
        String exampleTranslation
    ) {}

    public GeminiResult enrich(String word, String partOfSpeech, String definitionEn,
                                String existingExample, String existingMeaningVi) {
        if (apiKey == null || apiKey.isBlank() || apiKey.equals("PASTE_YOUR_GEMINI_API_KEY_HERE")) {
            return null;
        }

        String prompt = buildPrompt(word, partOfSpeech, definitionEn, existingExample, existingMeaningVi);

        try {
            RestTemplate rt = new RestTemplate();
            Map<String, Object> body = Map.of(
                "contents", List.of(Map.of(
                    "parts", List.of(Map.of("text", prompt))
                )),
                "generationConfig", Map.of(
                    "temperature", 0.2,
                    "maxOutputTokens", 256
                )
            );

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_JSON);
            HttpEntity<Map<String, Object>> request = new HttpEntity<>(body, headers);

            ResponseEntity<String> response = rt.postForEntity(GEMINI_URL + apiKey, request, String.class);
            if (response.getBody() == null) return null;

            JsonNode root = mapper.readTree(response.getBody());
            String text = root.path("candidates").get(0)
                .path("content").path("parts").get(0)
                .path("text").asText();

            // Strip markdown code fences if present
            text = text.replaceAll("(?s)```json", "").replaceAll("```", "").trim();
            // Extract first JSON object in case there's extra text
            int start = text.indexOf('{');
            int end   = text.lastIndexOf('}');
            if (start >= 0 && end > start) text = text.substring(start, end + 1);

            log.debug("Gemini raw response for '{}': {}", word, text);

            JsonNode json = mapper.readTree(text);

            String difficulty = normalizeEnum(json.path("difficulty").asText(null),
                List.of("BEGINNER", "INTERMEDIATE", "ADVANCED"));
            String category   = normalizeCategory(json.path("category").asText(null));

            return new GeminiResult(
                difficulty,
                category,
                blankToNull(json.path("meaningVi").asText(null)),
                blankToNull(json.path("exampleSentence").asText(null)),
                blankToNull(json.path("exampleTranslation").asText(null))
            );
        } catch (Exception e) {
            log.warn("Gemini enrichment failed for word '{}': {}", word, e.getMessage());
            return null;
        }
    }

    private String normalizeEnum(String value, List<String> allowed) {
        if (value == null) return null;
        String upper = value.trim().toUpperCase();
        return allowed.contains(upper) ? upper : null;
    }

    private static final List<String> CATEGORY_LIST = List.of(
        "Achievement","Actions","Animals","Body","Business","Character","Clothing",
        "Communication","Culture","Descriptive","Education","Emotions","Entertainment",
        "Food","General","Health","Home","Language","Nature","People","Places",
        "Politics","Shopping","Social","Technology","Thinking","Time","Transport","Travel","Work"
    );

    private String normalizeCategory(String value) {
        if (value == null) return null;
        String trimmed = value.trim();
        // exact match (case-insensitive)
        for (String c : CATEGORY_LIST) {
            if (c.equalsIgnoreCase(trimmed)) return c;
        }
        return null;
    }

    private String blankToNull(String value) {
        return (value == null || value.isBlank()) ? null : value.trim();
    }

    private String buildPrompt(String word, String partOfSpeech, String definitionEn,
                                String existingExample, String existingMeaningVi) {
        return String.format("""
            You are building an English-Vietnamese vocabulary learning app.
            Given the following word data, return a JSON object with these fields:
            - difficulty: BEGINNER (very common words, A1-A2), INTERMEDIATE (moderately common, B1-B2), or ADVANCED (rare/specialized, C1-C2)
            - category: best matching category from this list only: %s
            - meaningVi: a natural, concise Vietnamese translation (2-6 words, no extra explanation)
            - exampleSentence: a simple English example sentence (use existing one if good, otherwise create one)
            - exampleTranslation: Vietnamese translation of the example sentence

            Word: %s
            Part of speech: %s
            English definition: %s
            Existing example: %s
            Existing Vietnamese translation: %s

            Respond ONLY with valid JSON, no markdown, no explanation.
            {"difficulty":"...","category":"...","meaningVi":"...","exampleSentence":"...","exampleTranslation":"..."}
            """,
            CATEGORIES, word,
            partOfSpeech != null ? partOfSpeech : "unknown",
            definitionEn != null ? definitionEn : "N/A",
            existingExample != null ? existingExample : "none",
            existingMeaningVi != null ? existingMeaningVi : "none"
        );
    }
}

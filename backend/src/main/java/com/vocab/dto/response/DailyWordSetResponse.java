package com.vocab.dto.response;

import com.vocab.entity.DailyWordSet;
import lombok.Builder;
import lombok.Data;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Data
@Builder
public class DailyWordSetResponse {
    private Long id;
    private LocalDate studyDate;
    private Boolean completed;
    private Integer wordsStudied;
    private Integer totalWords;
    private List<WordResponse> words;
    private LocalDateTime createdAt;

    public static DailyWordSetResponse from(DailyWordSet set) {
        return DailyWordSetResponse.builder()
            .id(set.getId())
            .studyDate(set.getStudyDate())
            .completed(set.getCompleted())
            .wordsStudied(set.getWordsStudied())
            .totalWords(set.getWords().size())
            .words(set.getWords().stream().map(WordResponse::from).collect(Collectors.toList()))
            .createdAt(set.getCreatedAt())
            .build();
    }
}

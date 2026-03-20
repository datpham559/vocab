package com.vocab.entity;

import com.vocab.entity.enums.WordDifficulty;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "words")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Word {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 100)
    private String word;

    @Column(length = 200)
    private String pronunciation;

    @Column(name = "meaning_vi", nullable = false, columnDefinition = "NVARCHAR(MAX)")
    private String meaningVi;

    @Column(name = "part_of_speech", length = 20)
    private String partOfSpeech;

    @Column(name = "example_sentence", columnDefinition = "NVARCHAR(MAX)")
    private String exampleSentence;

    @Column(name = "example_translation", columnDefinition = "NVARCHAR(MAX)")
    private String exampleTranslation;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    @Builder.Default
    private WordDifficulty difficulty = WordDifficulty.BEGINNER;

    @Column(length = 50)
    private String category;

    @Column(name = "image_url", length = 500)
    private String imageUrl;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}

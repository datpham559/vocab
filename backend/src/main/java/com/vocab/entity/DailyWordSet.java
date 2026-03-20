package com.vocab.entity;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "daily_word_sets",
    uniqueConstraints = @UniqueConstraint(columnNames = {"user_id", "study_date"}))
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class DailyWordSet {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "study_date", nullable = false)
    private LocalDate studyDate;

    @Column(nullable = false)
    @Builder.Default
    private Boolean completed = false;

    @Column(name = "words_studied", nullable = false)
    @Builder.Default
    private Integer wordsStudied = 0;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @ManyToMany(fetch = FetchType.LAZY)
    @JoinTable(
        name = "daily_word_set_words",
        joinColumns = @JoinColumn(name = "daily_word_set_id"),
        inverseJoinColumns = @JoinColumn(name = "word_id")
    )
    @Builder.Default
    private List<Word> words = new ArrayList<>();

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}

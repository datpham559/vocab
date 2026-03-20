package com.vocab.repository;

import com.vocab.entity.Word;
import com.vocab.entity.enums.WordDifficulty;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface WordRepository extends JpaRepository<Word, Long> {

    Page<Word> findByDifficulty(WordDifficulty difficulty, Pageable pageable);

    Page<Word> findByCategory(String category, Pageable pageable);

    Page<Word> findByDifficultyAndCategory(WordDifficulty difficulty, String category, Pageable pageable);

    @Query("SELECT w FROM Word w WHERE LOWER(w.word) LIKE LOWER(CONCAT('%', :keyword, '%')) " +
           "OR LOWER(w.meaningVi) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    Page<Word> searchWords(@Param("keyword") String keyword, Pageable pageable);

    @Query(value = "SELECT * FROM words WHERE word LIKE :prefix + '%'",
           countQuery = "SELECT COUNT(*) FROM words WHERE word LIKE :prefix + '%'",
           nativeQuery = true)
    Page<Word> findByWordStartingWith(@Param("prefix") String prefix, Pageable pageable);

    @Query(value = "SELECT * FROM words WHERE word LIKE :prefix + '%' AND difficulty = :difficulty",
           countQuery = "SELECT COUNT(*) FROM words WHERE word LIKE :prefix + '%' AND difficulty = :difficulty",
           nativeQuery = true)
    Page<Word> findByWordStartingWithAndDifficulty(@Param("prefix") String prefix, @Param("difficulty") String difficulty, Pageable pageable);

    long countByDifficulty(WordDifficulty difficulty);

    @Query(value = "SELECT TOP (:limit) * FROM words " +
                   "WHERE id NOT IN (SELECT word_id FROM user_word_progress WHERE user_id = :userId) " +
                   "ORDER BY NEWID()",
           nativeQuery = true)
    List<Word> findNewWordsForUser(@Param("userId") Long userId, @Param("limit") int limit);

    @Query(value = "SELECT TOP (:limit) * FROM words " +
                   "WHERE difficulty = :difficulty AND id != :excludeId " +
                   "ORDER BY NEWID()",
           nativeQuery = true)
    List<Word> findDistractors(@Param("difficulty") String difficulty,
                               @Param("excludeId") Long excludeId,
                               @Param("limit") int limit);
}

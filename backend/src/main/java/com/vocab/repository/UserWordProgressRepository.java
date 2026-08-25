package com.vocab.repository;

import com.vocab.entity.UserWordProgress;
import com.vocab.entity.enums.ProgressStatus;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserWordProgressRepository extends JpaRepository<UserWordProgress, Long> {

    Optional<UserWordProgress> findByUserIdAndWordId(Long userId, Long wordId);

    // JOIN FETCH p.word: callers map every row through p.getWord() (building responses,
    // picking words for a session) — without it, each row would trigger its own lazy-load
    // query (N+1) since UserWordProgress.word is a LAZY @ManyToOne.
    @Query("SELECT p FROM UserWordProgress p JOIN FETCH p.word WHERE p.user.id = :userId")
    List<UserWordProgress> findByUserId(@Param("userId") Long userId);

    List<UserWordProgress> findByUserIdAndStatus(Long userId, ProgressStatus status);

    long countByUserIdAndStatus(Long userId, ProgressStatus status);

    @Query("SELECT p FROM UserWordProgress p JOIN FETCH p.word WHERE p.user.id = :userId " +
           "AND p.status IN ('LEARNING', 'REVIEW') " +
           "AND (p.nextReview IS NULL OR p.nextReview <= :today)")
    List<UserWordProgress> findDueForReview(@Param("userId") Long userId,
                                            @Param("today") LocalDate today);

    @Query("SELECT p FROM UserWordProgress p WHERE p.user.id = :userId " +
           "AND p.status IN ('LEARNING', 'REVIEW', 'MASTERED') " +
           "AND p.nextReview <= :today")
    List<UserWordProgress> findAllDueForReview(@Param("userId") Long userId,
                                               @Param("today") LocalDate today);

    @Query("SELECT COUNT(p) FROM UserWordProgress p WHERE p.user.id = :userId " +
           "AND p.status IN ('LEARNING', 'REVIEW', 'MASTERED') " +
           "AND p.nextReview <= :today")
    long countDueForReview(@Param("userId") Long userId, @Param("today") LocalDate today);

    // Cycle-based review: all learned words, page/limit applied via Pageable (e.g.
    // PageRequest.of(0, limit, Sort.by("lastReviewed").ascending()) — never-reviewed first).
    @Query("SELECT p FROM UserWordProgress p JOIN FETCH p.word WHERE p.user.id = :userId AND p.status <> 'NEW'")
    List<UserWordProgress> findForReviewCycle(@Param("userId") Long userId, Pageable pageable);

    @Query("SELECT COUNT(p) FROM UserWordProgress p WHERE p.user.id = :userId AND p.status <> 'NEW'")
    long countLearned(@Param("userId") Long userId);

    @Query("SELECT p FROM UserWordProgress p JOIN FETCH p.word WHERE p.user.id = :userId AND p.bookmarked = true")
    List<UserWordProgress> findByUserIdAndBookmarkedTrue(@Param("userId") Long userId);
}

package com.vocab.repository;

import com.vocab.entity.UserWordProgress;
import com.vocab.entity.enums.ProgressStatus;
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

    List<UserWordProgress> findByUserId(Long userId);

    List<UserWordProgress> findByUserIdAndStatus(Long userId, ProgressStatus status);

    long countByUserIdAndStatus(Long userId, ProgressStatus status);

    @Query("SELECT p FROM UserWordProgress p WHERE p.user.id = :userId " +
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

    // Cycle-based review: all learned words ordered by lastReviewed ASC (never-reviewed first)
    @Query(value = "SELECT TOP (:limit) p.* FROM user_word_progress p " +
           "WHERE p.user_id = :userId AND p.status <> 'NEW' " +
           "ORDER BY p.last_reviewed ASC",
           nativeQuery = true)
    List<UserWordProgress> findForReviewCycle(@Param("userId") Long userId,
                                              @Param("limit") int limit);

    @Query("SELECT COUNT(p) FROM UserWordProgress p WHERE p.user.id = :userId AND p.status <> 'NEW'")
    long countLearned(@Param("userId") Long userId);

    List<UserWordProgress> findByUserIdAndBookmarkedTrue(Long userId);
}

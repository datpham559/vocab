package com.vocab.repository;

import com.vocab.entity.DailyWordSet;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.Optional;

@Repository
public interface DailyWordSetRepository extends JpaRepository<DailyWordSet, Long> {

    Optional<DailyWordSet> findByUserIdAndStudyDate(Long userId, LocalDate studyDate);

    long countByUserIdAndCompletedTrue(Long userId);
}

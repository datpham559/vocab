package com.vocab.repository;

import com.vocab.entity.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);

    // Pageable bounds the result at the DB level (e.g. PageRequest.of(0, limit)) instead of
    // loading every user and truncating in Java.
    @Query("SELECT u FROM User u ORDER BY u.streak DESC, u.totalWordsLearned DESC")
    List<User> findTopByStreak(Pageable pageable);

    @Query("SELECT u FROM User u ORDER BY u.totalWordsLearned DESC, u.streak DESC")
    List<User> findTopByWords(Pageable pageable);
}

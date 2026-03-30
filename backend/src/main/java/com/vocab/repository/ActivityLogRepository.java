package com.vocab.repository;

import com.vocab.entity.ActivityLog;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ActivityLogRepository extends JpaRepository<ActivityLog, Long> {

    Page<ActivityLog> findAllByOrderByCreatedAtDesc(Pageable pageable);

    Page<ActivityLog> findByActionTypeOrderByCreatedAtDesc(String actionType, Pageable pageable);

    List<ActivityLog> findByUserIdOrderByCreatedAtDesc(Long userId);

    Page<ActivityLog> findByUsernameContainingIgnoreCaseOrderByCreatedAtDesc(String username, Pageable pageable);
}

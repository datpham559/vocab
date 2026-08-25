--liquibase formatted sql

--changeset vocab:068-add-user-word-progress-composite-indexes
-- Backs findDueForReview / findAllDueForReview / countDueForReview, which filter
-- user_id + status + next_review together (previously only single-column indexes existed).
CREATE INDEX idx_uwp_user_status_nextreview ON user_word_progress (user_id, status, next_review);

-- Backs findForReviewCycle, which filters user_id + status and orders by last_reviewed.
CREATE INDEX idx_uwp_user_status_lastreviewed ON user_word_progress (user_id, status, last_reviewed);
--rollback DROP INDEX idx_uwp_user_status_nextreview ON user_word_progress; DROP INDEX idx_uwp_user_status_lastreviewed ON user_word_progress;

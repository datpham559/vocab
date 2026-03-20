--liquibase formatted sql

--changeset vocab-dev:007-seed-admin-user
-- Password: Admin@123  (BCrypt encoded, cost factor 10)
INSERT INTO users (username, email, password, display_name, streak, total_words_learned, created_at, updated_at)
VALUES (
    N'admin',
    N'admin@vocab.com',
    N'$2a$12$tVA.Bh6pXMGgylsMrbJh1OxExkSFfW7af2Bb5/c3CkPSyw0YuqnDq',
    N'Administrator',
    0,
    0,
    GETDATE(),
    GETDATE()
);
-- Admin@123
--rollback DELETE FROM users WHERE username = 'admin';

--liquibase formatted sql

-- ============================================================
-- 001 — users
-- ============================================================
--changeset vocab-dev:001-create-users-table
CREATE TABLE users (
    id              BIGINT IDENTITY(1,1) NOT NULL,
    username        NVARCHAR(50)         NOT NULL,
    email           NVARCHAR(100)        NOT NULL,
    password        NVARCHAR(255)        NOT NULL,
    display_name    NVARCHAR(100)        NULL,
    streak          INT                  NOT NULL DEFAULT 0,
    last_study_date DATE                 NULL,
    total_words_learned INT              NOT NULL DEFAULT 0,
    created_at      DATETIME2            NOT NULL DEFAULT GETDATE(),
    updated_at      DATETIME2            NOT NULL DEFAULT GETDATE(),

    CONSTRAINT pk_users          PRIMARY KEY (id),
    CONSTRAINT uk_users_username UNIQUE (username),
    CONSTRAINT uk_users_email    UNIQUE (email)
);
--rollback DROP TABLE users;

-- ============================================================
-- 002 — words
-- ============================================================
--changeset vocab-dev:002-create-words-table
CREATE TABLE words (
    id                   BIGINT IDENTITY(1,1) NOT NULL,
    word                 NVARCHAR(100)         NOT NULL,
    pronunciation        NVARCHAR(200)         NULL,
    meaning_vi           NVARCHAR(MAX)         NOT NULL,
    part_of_speech       NVARCHAR(20)          NULL,
    example_sentence     NVARCHAR(MAX)         NULL,
    example_translation  NVARCHAR(MAX)         NULL,
    difficulty           NVARCHAR(20)          NOT NULL DEFAULT 'BEGINNER',
    category             NVARCHAR(50)          NULL,
    image_url            NVARCHAR(500)         NULL,
    created_at           DATETIME2             NOT NULL DEFAULT GETDATE(),

    CONSTRAINT pk_words             PRIMARY KEY (id),
    CONSTRAINT uk_words_word        UNIQUE (word),
    CONSTRAINT chk_words_difficulty CHECK (difficulty IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED'))
);
--rollback DROP TABLE words;

-- ============================================================
-- 003 — user_word_progress
-- ============================================================
--changeset vocab-dev:003-create-user-word-progress-table
CREATE TABLE user_word_progress (
    id            BIGINT IDENTITY(1,1) NOT NULL,
    user_id       BIGINT               NOT NULL,
    word_id       BIGINT               NOT NULL,
    status        NVARCHAR(20)         NOT NULL DEFAULT 'NEW',
    correct_count INT                  NOT NULL DEFAULT 0,
    wrong_count   INT                  NOT NULL DEFAULT 0,
    last_reviewed DATETIME2            NULL,
    next_review   DATE                 NULL,
    created_at    DATETIME2            NOT NULL DEFAULT GETDATE(),

    CONSTRAINT pk_user_word_progress PRIMARY KEY (id),
    CONSTRAINT uk_uwp_user_word      UNIQUE (user_id, word_id),
    CONSTRAINT fk_uwp_user           FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_uwp_word           FOREIGN KEY (word_id) REFERENCES words(id),
    CONSTRAINT chk_uwp_status        CHECK (status IN ('NEW', 'LEARNING', 'REVIEW', 'MASTERED'))
);

CREATE INDEX idx_uwp_user_id     ON user_word_progress (user_id);
CREATE INDEX idx_uwp_next_review ON user_word_progress (next_review);
--rollback DROP TABLE user_word_progress;

-- ============================================================
-- 004 — daily_word_sets
-- ============================================================
--changeset vocab-dev:004-create-daily-word-sets-table
CREATE TABLE daily_word_sets (
    id           BIGINT IDENTITY(1,1) NOT NULL,
    user_id      BIGINT               NOT NULL,
    study_date   DATE                 NOT NULL,
    completed    BIT                  NOT NULL DEFAULT 0,
    words_studied INT                 NOT NULL DEFAULT 0,
    created_at   DATETIME2            NOT NULL DEFAULT GETDATE(),

    CONSTRAINT pk_daily_word_sets PRIMARY KEY (id),
    CONSTRAINT uk_dws_user_date   UNIQUE (user_id, study_date),
    CONSTRAINT fk_dws_user        FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_dws_user_date ON daily_word_sets (user_id, study_date);
--rollback DROP TABLE daily_word_sets;

-- ============================================================
-- 005 — daily_word_set_words
-- ============================================================
--changeset vocab-dev:005-create-daily-word-set-words-table
CREATE TABLE daily_word_set_words (
    daily_word_set_id BIGINT NOT NULL,
    word_id           BIGINT NOT NULL,

    CONSTRAINT pk_daily_word_set_words PRIMARY KEY (daily_word_set_id, word_id),
    CONSTRAINT fk_dwsw_daily_set       FOREIGN KEY (daily_word_set_id) REFERENCES daily_word_sets(id),
    CONSTRAINT fk_dwsw_word            FOREIGN KEY (word_id)           REFERENCES words(id)
);
--rollback DROP TABLE daily_word_set_words;

-- ============================================================
-- 054 — add role to users
-- ============================================================
--changeset vocab:054-add-role-to-users
ALTER TABLE users ADD role NVARCHAR(20) NOT NULL DEFAULT 'ROLE_USER';
UPDATE users SET role = 'ROLE_ADMIN' WHERE username = 'admin';
--rollback ALTER TABLE users DROP COLUMN role;

-- ============================================================
-- 056 — activity_logs table
-- ============================================================
--changeset vocab:056-create-activity-logs
CREATE TABLE activity_logs (
    id          BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id     BIGINT NULL,
    username    VARCHAR(100) NULL,
    action_type VARCHAR(50)  NOT NULL,
    description NVARCHAR(500) NULL,
    created_at  DATETIME2    NOT NULL DEFAULT GETDATE()
);

CREATE INDEX idx_activity_logs_user_id    ON activity_logs (user_id);
CREATE INDEX idx_activity_logs_created_at ON activity_logs (created_at DESC);
CREATE INDEX idx_activity_logs_action     ON activity_logs (action_type);

-- ============================================================
-- 057 — bookmarked column on user_word_progress
-- ============================================================
--changeset vocab:057-add-bookmarked-to-progress
ALTER TABLE user_word_progress ADD bookmarked BIT NOT NULL DEFAULT 0;
CREATE INDEX idx_uwp_bookmarked ON user_word_progress (user_id, bookmarked);

-- ============================================================
-- 058 — ip_address column on activity_logs
-- ============================================================
--changeset vocab:058-add-ip-to-activity-logs
ALTER TABLE activity_logs ADD ip_address VARCHAR(45) NULL;

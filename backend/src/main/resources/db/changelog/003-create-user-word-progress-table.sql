--liquibase formatted sql

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

    CONSTRAINT pk_user_word_progress   PRIMARY KEY (id),
    CONSTRAINT uk_uwp_user_word        UNIQUE (user_id, word_id),
    CONSTRAINT fk_uwp_user             FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_uwp_word             FOREIGN KEY (word_id) REFERENCES words(id),
    CONSTRAINT chk_uwp_status          CHECK (status IN ('NEW', 'LEARNING', 'REVIEW', 'MASTERED'))
);

CREATE INDEX idx_uwp_user_id    ON user_word_progress (user_id);
CREATE INDEX idx_uwp_next_review ON user_word_progress (next_review);
--rollback DROP TABLE user_word_progress;

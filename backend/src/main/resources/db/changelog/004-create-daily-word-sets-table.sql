--liquibase formatted sql

--changeset vocab-dev:004-create-daily-word-sets-table
CREATE TABLE daily_word_sets (
    id           BIGINT IDENTITY(1,1) NOT NULL,
    user_id      BIGINT               NOT NULL,
    study_date   DATE                 NOT NULL,
    completed    BIT                  NOT NULL DEFAULT 0,
    words_studied INT                 NOT NULL DEFAULT 0,
    created_at   DATETIME2            NOT NULL DEFAULT GETDATE(),

    CONSTRAINT pk_daily_word_sets  PRIMARY KEY (id),
    CONSTRAINT uk_dws_user_date    UNIQUE (user_id, study_date),
    CONSTRAINT fk_dws_user         FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE INDEX idx_dws_user_date ON daily_word_sets (user_id, study_date);
--rollback DROP TABLE daily_word_sets;

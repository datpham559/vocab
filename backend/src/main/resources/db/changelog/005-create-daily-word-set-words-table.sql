--liquibase formatted sql

--changeset vocab-dev:005-create-daily-word-set-words-table
CREATE TABLE daily_word_set_words (
    daily_word_set_id BIGINT NOT NULL,
    word_id           BIGINT NOT NULL,

    CONSTRAINT pk_daily_word_set_words PRIMARY KEY (daily_word_set_id, word_id),
    CONSTRAINT fk_dwsw_daily_set       FOREIGN KEY (daily_word_set_id) REFERENCES daily_word_sets(id),
    CONSTRAINT fk_dwsw_word            FOREIGN KEY (word_id)           REFERENCES words(id)
);
--rollback DROP TABLE daily_word_set_words;

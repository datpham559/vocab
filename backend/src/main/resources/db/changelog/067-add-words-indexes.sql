--liquibase formatted sql

--changeset vocab:067-add-words-indexes
CREATE INDEX idx_words_difficulty ON words (difficulty);
CREATE INDEX idx_words_category ON words (category);
CREATE INDEX idx_words_part_of_speech ON words (part_of_speech);
--rollback DROP INDEX idx_words_difficulty ON words; DROP INDEX idx_words_category ON words; DROP INDEX idx_words_part_of_speech ON words;

--liquibase formatted sql

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

    CONSTRAINT pk_words              PRIMARY KEY (id),
    CONSTRAINT uk_words_word         UNIQUE (word),
    CONSTRAINT chk_words_difficulty  CHECK (difficulty IN ('BEGINNER', 'INTERMEDIATE', 'ADVANCED'))
);
--rollback DROP TABLE words;

--liquibase formatted sql

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

    CONSTRAINT pk_users PRIMARY KEY (id),
    CONSTRAINT uk_users_username UNIQUE (username),
    CONSTRAINT uk_users_email    UNIQUE (email)
);
--rollback DROP TABLE users;

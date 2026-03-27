--liquibase formatted sql

--changeset vocab:054-add-role-to-users
ALTER TABLE users ADD role NVARCHAR(20) NOT NULL DEFAULT 'ROLE_USER';
UPDATE users SET role = 'ROLE_ADMIN' WHERE username = 'admin';

--rollback ALTER TABLE users DROP COLUMN role;

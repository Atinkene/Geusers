-- Database: geusers

CREATE DATABASE IF NOT EXISTS geusers
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE geusers;

-- Users table 
CREATE TABLE IF NOT EXISTS users (
    id          INT             NOT NULL AUTO_INCREMENT,
    first_name  VARCHAR(50)     NOT NULL,
    last_name   VARCHAR(50)     NOT NULL,
    username    VARCHAR(30)     NOT NULL,
    password    VARCHAR(255)    NOT NULL, 
    created_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
                                        ON UPDATE CURRENT_TIMESTAMP,

    CONSTRAINT pk_users         PRIMARY KEY (id),
    CONSTRAINT uq_users_username UNIQUE (username)
);

-- Indexes
CREATE INDEX idx_users_username ON users (username);

ALTER TABLE users 
ADD COLUMN role ENUM('admin', 'lambda') NOT NULL DEFAULT 'lambda' AFTER password;



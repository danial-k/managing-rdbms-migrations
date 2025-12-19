CREATE TABLE users (
    -- Default fields
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(36) NOT NULL DEFAULT (UUID()),
    is_deleted TINYINT NOT NULL DEFAULT 0,
    created DATETIME(6),
    modified DATETIME(6),
    -- Custom fields
    first_name VARCHAR(255) NOT NULL,
    middle_name VARCHAR(255),
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL
    -- Constraints (default)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

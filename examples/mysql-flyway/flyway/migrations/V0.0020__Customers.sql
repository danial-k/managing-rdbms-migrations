CREATE TABLE customers (
    -- Default fields
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(36) NOT NULL DEFAULT (UUID()),
    creator_id BIGINT NOT NULL,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    created DATETIME(6),
    modified DATETIME(6),
    -- Custom fields
    title VARCHAR(255) NOT NULL,
    -- Constraints (default)
    FOREIGN KEY (creator_id) REFERENCES users(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE TABLE purchases (
    -- Default fields
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(36) NOT NULL DEFAULT (UUID()),
    creator_id BIGINT NOT NULL,
    is_deleted TINYINT NOT NULL DEFAULT 0,
    created DATETIME(6),
    modified DATETIME(6),
    -- Custom fields
    supplier_id BIGINT NOT NULL,
    title VARCHAR(255) NOT NULL,
    body LONGTEXT,
    manual_value DECIMAL(13,4) DEFAULT 0.0,
    -- Constraints (default)
    FOREIGN KEY (creator_id) REFERENCES users(id),
    -- Constraints (custom)
    FOREIGN KEY (supplier_id) REFERENCES customers(id)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

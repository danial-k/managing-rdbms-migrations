CREATE TABLE users (
    -- Default fields
    id bigserial primary key,
    uid uuid not null unique,
    is_deleted boolean not null default false,
    created timestamp with time zone not null default now(),
    modified timestamp with time zone not null default now(),
    -- Custom fields
    first_name varchar(255) NOT NULL,
    middle_name varchar(255),
    last_name varchar(255) NOT NULL,
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL
    -- Constraints (default)
);

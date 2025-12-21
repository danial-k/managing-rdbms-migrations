CREATE TABLE customers (
    -- Default fields
    id bigserial primary key,
    uid uuid not null unique,
    creator_id bigint not null,
    is_deleted boolean not null default false,
    created timestamp with time zone not null default now(),
    modified timestamp with time zone not null default now(),
    -- Custom fields
    title varchar(255) not null,
    -- Constraints (default)
    foreign key (creator_id) references users(id)
);

CREATE TABLE purchases (
    -- Default fields
    id bigserial primary key,
    uid uuid not null unique,
    creator_id bigint not null,
    is_deleted boolean not null default false,
    created timestamp with time zone not null default now(),
    modified timestamp with time zone not null default now(),
    -- Custom fields
    supplier_id bigint not null,
    title varchar(255) not null,
    body text,
    manual_value decimal(13,4) default 0.0,
    -- Constraints (default)
    foreign key (creator_id) references users(id),
    -- Constraints (custom)
    foreign key (supplier_id) references customers(id)
);

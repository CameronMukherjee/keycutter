CREATE TABLE IF NOT EXISTS kc_error_log
(
    sid            bigserial primary key,
    uid            uuid          not null unique,
    exception_type varchar(255)  not null,
    message        varchar(1500) not null,
    metadata       varchar(1500),
    created_at     timestamptz   not null default now()
);
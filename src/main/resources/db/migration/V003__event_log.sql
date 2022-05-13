CREATE TABLE IF NOT EXISTS kc_event_log
(
    sid         bigserial primary key,
    uid         uuid unique not null,
    kc_user_sid bigserial references kc_user (sid),
    event_type  event_type  not null,
    system_env  varchar(20) not null,
    created_at  timestamptz default now()
);
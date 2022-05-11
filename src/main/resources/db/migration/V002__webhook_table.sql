CREATE TYPE event_type AS ENUM ('USER_CREATED', 'USER_UPDATED', 'USER_PASSWORD_CHANGE', 'USER_DELETED', 'USER_DISABLED', 'USER_ENABLED', 'USER_RESET_PASSWORD', 'ROLE_APPENDED', 'ROLE_REMOVED', 'ROLES_REMOVED', 'WELCOME_EMAIL_DISPATCHED', 'FORGOTTEN_PASSWORD_EMAIL_DISPATCHED');

CREATE TABLE IF NOT EXISTS kc_webhook
(
    sid           bigserial primary key,
    uid           uuid unique          not null,
    webhook_url   varchar(1000) unique not null,
    is_disabled   bool                 not null default false,
    last_dispatch timestamptz,
    created_at    timestamptz          not null default now()
);

CREATE TABLE IF NOT EXISTS kc_webhook_register
(
    uid            uuid unique primary key,
    kc_webhook_sid bigserial references kc_webhook (sid) on delete cascade,
    event_type     event_type not null
);
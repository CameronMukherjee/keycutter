CREATE TYPE login_result as enum ('SUCCESS', 'FAILED');

CREATE TABLE IF NOT EXISTS kc_user
(
    sid                bigserial primary key,
    uid                uuid          not null unique,
    external_reference varchar(255)  not null unique,
    username           varchar(255)  not null unique,
    password           varchar(5000) not null,
    is_disabled        bool          not null default false,
    updated_at         timestamptz   not null default now(),
    created_at         timestamptz   not null default now()
);

CREATE TABLE IF NOT EXISTS kc_login_log
(
    sid          bigserial primary key,
    uid          uuid         not null unique,
    kc_user_sid  bigserial references kc_user (sid) on delete cascade,
    login_result login_result not null,
    created_at   timestamptz  not null default now()
);

CREATE TABLE IF NOT EXISTS kc_user_role
(
    uid         uuid primary key,
    kc_user_sid bigserial references kc_user (sid) on delete cascade,
    role        varchar(255) not null,
    created_at  timestamptz  not null default now()
);
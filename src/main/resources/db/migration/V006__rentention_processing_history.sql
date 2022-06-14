CREATE TABLE IF NOT EXISTS kc_retention_processing_log
(
    sid                bigserial primary key,
    uid                uuid unique not null,
    log_type           varchar     not null,
    entities_processed int         not null,
    strategy           varchar     not null,
    created_at         timestamptz not null
);

CREATE VIEW retention_entity_count AS
SELECT log_type, strategy, sum(entities_processed) as entities_processed
FROM kc_retention_processing_log
GROUP BY log_type, strategy;
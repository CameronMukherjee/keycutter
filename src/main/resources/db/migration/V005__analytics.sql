CREATE VIEW kc_login_count AS
SELECT (SELECT count(*)
        FROM kc_login_log
        WHERE created_at BETWEEN now() - INTERVAL '24 HOURS' AND now()) as one_day,
       (SELECT count(*)
        FROM kc_login_log
        WHERE created_at BETWEEN now() - INTERVAL '1 WEEK' AND now())   as one_week,
       (SELECT count(*)
        FROM kc_login_log
        WHERE created_at BETWEEN now() - INTERVAL '1 MONTH' AND now())  as one_month,
       (SELECT count(*)
        FROM kc_login_log
        WHERE created_at BETWEEN now() - INTERVAL '3 MONTH' AND now())  as three_months,
       (SELECT count(*)
        FROM kc_login_log
        WHERE created_at BETWEEN now() - INTERVAL '6 MONTH' AND now())  as six_months,
       (SELECT count(*)
        FROM kc_login_log
        WHERE created_at BETWEEN now() - INTERVAL '1 YEAR' AND now())   as one_year,
       (SELECT count(*) FROM kc_login_log)                              as all_time;

CREATE VIEW kc_event_count AS
SELECT (SELECT count(*)
        FROM kc_event_log
        WHERE created_at BETWEEN now() - INTERVAL '24 HOURS' AND now()) as one_day,
       (SELECT count(*)
        FROM kc_event_log
        WHERE created_at BETWEEN now() - INTERVAL '1 WEEK' AND now())   as one_week,
       (SELECT count(*)
        FROM kc_event_log
        WHERE created_at BETWEEN now() - INTERVAL '1 MONTH' AND now())  as one_month,
       (SELECT count(*)
        FROM kc_event_log
        WHERE created_at BETWEEN now() - INTERVAL '3 MONTH' AND now())  as three_months,
       (SELECT count(*)
        FROM kc_event_log
        WHERE created_at BETWEEN now() - INTERVAL '6 MONTH' AND now())  as six_months,
       (SELECT count(*)
        FROM kc_event_log
        WHERE created_at BETWEEN now() - INTERVAL '1 YEAR' AND now())   as one_year,
       (SELECT count(*) FROM kc_event_log)                              as all_time;

CREATE VIEW kc_user_registration_count AS
SELECT (SELECT count(*)
        FROM kc_user
        WHERE created_at BETWEEN now() - INTERVAL '24 HOURS' AND now()) as one_day,
       (SELECT count(*)
        FROM kc_user
        WHERE created_at BETWEEN now() - INTERVAL '1 WEEK' AND now())   as one_week,
       (SELECT count(*)
        FROM kc_user
        WHERE created_at BETWEEN now() - INTERVAL '1 MONTH' AND now())  as one_month,
       (SELECT count(*)
        FROM kc_user
        WHERE created_at BETWEEN now() - INTERVAL '3 MONTH' AND now())  as three_months,
       (SELECT count(*)
        FROM kc_user
        WHERE created_at BETWEEN now() - INTERVAL '6 MONTH' AND now())  as six_months,
       (SELECT count(*)
        FROM kc_user
        WHERE created_at BETWEEN now() - INTERVAL '1 YEAR' AND now())   as one_year,
       (SELECT count(*) FROM kc_user)                                   as all_time;

CREATE VIEW kc_role_count AS
SELECT role, count(role) as users
FROM kc_user_role
group by role;
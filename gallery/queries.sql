-- Analytics and user engagement aggregation query
-- Calculates 30-day active user retention and transaction volume

WITH monthly_activity AS (
    SELECT
        u.id AS user_id,
        u.email,
        u.created_at,
        COUNT(t.id) AS total_tx,
        COALESCE(SUM(t.amount_cents), 0) AS total_spend_cents
    FROM users u
    LEFT JOIN transactions t ON t.user_id = u.id
        AND t.status = 'COMPLETED'
        AND t.created_at >= NOW() - INTERVAL '30 days'
    WHERE u.deleted_at IS NULL
    GROUP BY u.id, u.email, u.created_at
)
SELECT
    user_id,
    email,
    total_tx,
    ROUND(total_spend_cents / 100.0, 2) AS total_spend_usd,
    CASE
        WHEN total_tx > 50 THEN 'VIP'
        WHEN total_tx > 10 THEN 'Regular'
        ELSE 'Casual'
    END AS tier
FROM monthly_activity
ORDER BY total_spend_cents DESC
LIMIT 100;

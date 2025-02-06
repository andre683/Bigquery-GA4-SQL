SELECT
    COUNT(*) / COUNT(DISTINCT user_pseudo_id) AS avg_transaction_transaction_per_purchaser
FROM `tough-healer-395417.analytics_287163560.events_*`
WHERE _TABLE_SUFFIX BETWEEN '20240701' AND '20240731'
    AND event_name = 'purchase'
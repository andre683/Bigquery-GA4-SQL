WITH userinfo AS (
    SELECT
    user_pseudo_id,
    COUNTIF(event_name = 'page_view') AS page_view_count,
    COUNTIF(event_name = 'purchase') AS purchase_event_count
    FROM
     `tough-healer-395417.analytics_287163560.events_*`
    WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20250131'
    GROUP BY user_pseudo_id
)
SELECT
    (purchase_event_count > 0) AS purchaser,
    COUNT(*) AS user_count,
    SUM(page_view_count) AS total_pageviews,
    AVG(page_view_count) AS avg_pageviews
FROM userinfo
GROUP BY purchaser



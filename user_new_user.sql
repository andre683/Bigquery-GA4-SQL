--Get 'total user' count and 'new user' count

WITH user_info AS (
    SELECT
        user_pseudo_id,
        MAX(IF(event_name = 'first_visit', 1, 0)) AS is_new_user
        
    FROM
        `tough-healer-395417.analytics_287163560.events_*`
    WHERE _TABLE_SUFFIX BETWEEN '20241201' AND '20241231'
    GROUP BY
        1
)

SELECT
    COUNT(*) AS user_count,
    SUM(is_new_user) AS new_user_count
FROM user_info

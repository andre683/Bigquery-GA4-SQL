SELECT
    user_pseudo_id,
    (
    SELECT value.string_value
    FROM UNNEST(event_params)
    WHERE key = 'event_category' -- event_category is the custom event parameter
    ) AS event_category
FROM `tough-healer-395417.analytics_287163560.events_*`
WHERE
    event_name = 'cancel_membership' -- cancel_membership is the custom event
    AND _TABLE_SUFFIX BETWEEN '20250101' AND '20250131'
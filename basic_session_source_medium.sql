WITH temp AS (
  SELECT
    CONCAT(user_pseudo_id, (SELECT value.int_value FROM UNNEST(event_params) WHERE key = 'ga_session_id')) AS session_id,
    user_pseudo_id AS user_id,
    COALESCE(
      ARRAY_AGG((CASE WHEN collected_traffic_source.gclid IS NOT NULL THEN 'google' ELSE collected_traffic_source.manual_source END) 
      IGNORE NULLS ORDER BY event_timestamp ASC LIMIT 1)[SAFE_OFFSET(0)], --ignore nulls can be removed if you want to capture direct source in landing page
      '(direct)') AS session_source,
    COALESCE(
      ARRAY_AGG((CASE WHEN collected_traffic_source.gclid IS NOT NULL THEN 'cpc' ELSE collected_traffic_source.manual_medium END) 
      IGNORE NULLS ORDER BY event_timestamp ASC LIMIT 1)[SAFE_OFFSET(0)], --ignore nulls can be removed if you want to capture direct source in landing page
      '(none)') AS session_medium,
    SUM(ecommerce.purchase_revenue) AS revenue,
    COUNTIF(event_name = 'purchase') AS transactions --not unique
  FROM `tough-healer-395417.analytics_287163560.events_*`
  WHERE _TABLE_SUFFIX BETWEEN '20240701'AND '20240731'
  GROUP BY event_date, session_id, user_pseudo_id
)
SELECT
  session_source,
  session_medium,
  COUNT(DISTINCT user_id) AS total_users,
  COUNT(DISTINCT session_id) AS sessions,
  SUM(transactions) AS transactions,
  SUM(revenue) AS revenue
FROM temp
GROUP BY session_source, session_medium
ORDER BY total_users DESC

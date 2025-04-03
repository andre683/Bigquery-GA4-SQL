SELECT
    item_id,
    item_name,
    COUNT(DISTINCT user_pseudo_id) AS user_count
FROM `project.dataset.table`
WHERE
    _TABLE_SUFFIX BETWEEN '20250101' AND '20250131'
    AND event_name = 'add_to_cart'
GROUP BY 1, 2
ORDER BY user_count DESC
LIMIT 10
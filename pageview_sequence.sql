CREATE TEMP FUNCTION GetParamString(event_params ANY TYPE, param_name STRING)
AS ((SELECT ANY_VALUE(value.string_value) FROM UNNEST(event_params) WHERE key = param_name));

CREATE TEMP FUNCTION GetParamInt(event_params ANY TYPE, param_name STRING)
AS ((SELECT ANY_VALUE(value.int_value) FROM UNNEST(event_params) WHERE key = param_name));

SELECT
    user_pseudo_id,
    user_id,
    batch_page_id,
    batch_ordering_id,
    batch_event_index,
    event_name,
    GetParamInt(event_params, 'ga_session_id') AS ga_session_id,
    GetParamString(event_params, 'page_location') AS page_location,
    GetParamString(event_params, 'page_title') AS page_title,

    FROM
    `tough-healer-395417.analytics_287163560.events_*`
    WHERE _TABLE_SUFFIX BETWEEN '20250101' AND '20250101'
    AND event_name = 'page_view'

    ORDER BY
        user_pseudo_id,
        user_id,
        batch_page_id,
        batch_ordering_id,
        batch_event_index
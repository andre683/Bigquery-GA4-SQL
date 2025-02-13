# Basic event queries

1. User count and new user count: [user_new_user.sql](user_new_user.sql)
   - To get the total user count we count the number of distinct 'user_pseudo_id'.
   - To get the number of new users, we count the number of distinc 'user_pseudo_id' with the event 'first_visit'.

2. Source / Medium: [source_medium.sql](source_medium.sql)
   - Using ARRAY_AGG to grab the first source and medium in a session (not a perfect method when either source or medium are missing in an event).
   - If either are null, (direct) / (none) is asigned using COALESCE.
   - If the event contains a gclid (Google Ads click id), google / cpc is assigned using a CASE statement.

4. Average number of transactions per purchaser: [avg_transactions.sql](avg_transactions.sql)
   - The table is filtered to only include purchase events
   - We divide the total count (number of purchases) by count of distinct user_pseudo_ids (nubmer of purchasers) to get the average transactions per purchaser.

4. Values for a specific event name: [event_value.sql](event_value.sql)
   - Using a scalar subquery with UNNEST(event_param), we extract the values for the custom event parameter 'event_category' from the custom event 'cancel_membership'.

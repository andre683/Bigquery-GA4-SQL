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

5. Top 10 items added to cart: [top_items_added.sql](top_items_added.sql) 
   - Filtering 'add_to_cart' events, we list products added to cart by their 'item_id' and 'item_name' values
   - We need to group repeated products using GROUP BY item_id, item_name
   - Using COUNT DISTINCT for 'user_pseudo_id' gives us the unique user count for each product

6. Average number of pageviews by purchaser type: [avg_pageview_purchaser.sql](avg_pageview_purchaser.sql)
   - The UserInfo CTE filters by date and groups rows by user_pseudo_id, counting 'page_view' event rows and 'purchase' event rows for each unique user.
   - The main query groups the CTE by 'purchaser' (true or false), which is calculated using a boolean flag (true when 'purchaes_event_count is higher than 0 else false)
   - user_count is calculated counting all rows from the CTE (each row represents a unique user that had either a page_view or purchase event in their session)
   - total_page_views is calculated with a sum of page_vfiew_count
   - avg_page_views is calculated using the AVG function

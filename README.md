# Basic event queries

1. User count and new user count: [user_new_user.sql](user_new_user.sql)
   - To get the total user count we count the number of distinct 'user_pseudo_id'.
   - To get the number of new users, we count the number of distinc 'user_pseudo_id' with the event 'first_visit'.

2. Using ARRAY_AGG to grab the first source and medium in a session (not a perfect method when some UTMs are missing in an event)

3. Average number of transactions per purchaser: [avg_transactions.sql](avg_transactions.sql)
   - The table is filtered to only include purchase events
   - We divide the total count (number of purchases) by count of distinct user_pseudo_ids (nubmer of purchasers) to get the average transactions per purchaser.

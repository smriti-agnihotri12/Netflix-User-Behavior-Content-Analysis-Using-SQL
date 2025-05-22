
--  Observing Netflix User Retention and Content Growth Trends

SELECT
    subscription_type,
    COUNT(DISTINCT CASE WHEN DATEDIFF(last_payment_date2, join_date2) >= 30 THEN user_id END) AS retained_users,
    COUNT(DISTINCT user_id) AS total_users
FROM netflix_user_data
GROUP BY subscription_type;


-- What is the trend in the addition of new movies to Netflix over the years?
SELECT
    YEAR(date_added2) AS year_added,
    type,
    COUNT(*) AS total_added2,
    SUM(COUNT(*)) OVER (ORDER BY YEAR(date_added2)) AS successive_count
FROM
    netflix_data
WHERE
    type = 'Movie'
GROUP BY
    YEAR(date_added2), type
ORDER BY
    year_added;


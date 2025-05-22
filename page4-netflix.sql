-- Q4) User Engagement Patterns on Netflix


SELECT
    user_id,
    COUNT(*) AS total_watched,
   
    CASE
        WHEN COUNT(*) >= 30 THEN 'High Engagement'
        WHEN COUNT(*) >= 20 AND COUNT(*) < 30 THEN 'Medium Engagement'
        ELSE 'Low Engagement'
    END AS engagement_level
FROM
    netflix_data2_table
GROUP BY
    user_id
    order by count(*) desc;
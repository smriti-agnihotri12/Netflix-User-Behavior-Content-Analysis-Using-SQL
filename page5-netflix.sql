-- Q5 Content Popularity Analysis


SELECT movie_title, movie_users, NULL AS tv_show_title, NULL AS tv_show_users
FROM (
    SELECT title AS movie_title, COUNT(user_id) AS movie_users
    FROM netflix_data nd
    INNER JOIN netflix_data2_table nd2 ON nd.show_id = nd2.show_id
    WHERE title IS NOT NULL AND type = 'Movie'
    GROUP BY title
    ORDER BY COUNT(user_id) DESC
    LIMIT 1
) AS most_watched_movie

UNION ALL

SELECT NULL AS movie_title, NULL AS movie_users, tv_show_title, tv_show_users
FROM (
    SELECT title AS tv_show_title, COUNT(user_id) AS tv_show_users
    FROM netflix_data nd
    INNER JOIN netflix_data2_table nd2 ON nd.show_id = nd2.show_id
    WHERE title IS NOT NULL AND type = 'TV Show'
    GROUP BY title
    ORDER BY COUNT(user_id) DESC
    LIMIT 1
) AS most_watched_tv_show;


 -- 2) list the movie with highest no of users and its rating, duration.
SELECT title AS movie_title, rating AS movie_rating, duration AS movie_duration, user_count
FROM (
    SELECT 
        nd.title,
        nd.rating,
        nd.duration,
        COUNT(nd2.user_id) AS user_count,
        ROW_NUMBER() OVER (ORDER BY COUNT(nd2.user_id) DESC) AS rn
    FROM 
        netflix_data nd
    JOIN 
        netflix_data2_table nd2 ON nd.show_id = nd2.show_id
    WHERE 
        nd.type = 'Movie'
    GROUP BY 
        nd.title, nd.rating, nd.duration
) AS movie_data
limit 1;

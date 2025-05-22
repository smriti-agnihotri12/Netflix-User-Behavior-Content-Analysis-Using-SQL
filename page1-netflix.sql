-- Q1 Analyzing Content Distribution Trends in Netflix’s data


-- 1) What is the distribution of content types (movies and TV shows) within the Netflix platform
SELECT type, COUNT(*) AS count,
       CONCAT(ROUND((COUNT(*) / (SELECT COUNT(*) FROM netflix_data)) * 100, 2), '%') AS percentage
FROM netflix_data
WHERE type = 'Movie'
UNION
SELECT type, COUNT(*) AS count,
       CONCAT(ROUND((COUNT(*) / (SELECT COUNT(*) FROM netflix_data)) * 100, 2), '%') AS percentage
FROM netflix_data
WHERE type = 'TV Show';

-- 2) How does the distribution of content types (movies and TV shows) vary across different rating categories on Netflix
SELECT 
    rating,
    SUM(CASE WHEN type = 'Movie' THEN 1 ELSE 0 END) AS movie_count,
    SUM(CASE WHEN type = 'TV Show' THEN 1 ELSE 0 END) AS tv_show_count
FROM 
    netflix_data

GROUP BY 
    rating
ORDER BY 
    movie_count DESC, tv_show_count DESC;
    
    -- 3) -- TOP 10 GENRE
    
select listed_in, count(*) as top10_genres
from netflix_data
where listed_in is not null
group by listed_in
order by count(*) desc
limit 10;


    
    
    -- 4) country wise share of movies and tv shows
with movie as(
select country,count(*) as country_wise_movies
from netflix_data
where type="movie" 
group by country
),
tv_show as(
select country,count(*) as country_wise_tvshows
from netflix_data
where type="tv show" 
group by country
)
select m.country,  m.country_wise_movies, s.country_wise_tvshows
from movie m inner join tv_show s on m.country=s.country
where m.country is not null
order by 2 desc, 3 desc;



-- Strategic Insights: Leveraging Director Influence and Recent Releases 

-- 1) Identify the top 10 directors with the most content on Netflix and the count of their shows

select 
	 distinct director, 
    count(*) as total_directed
from 
      netflix_data
where 
      director is not null 
group by 
      director 
order by 
       count(*) desc
limit 10;


-- 2) How has the number of movies or TV shows created by well-known directors evolved over time.

    WITH DirectorContent AS (
    SELECT
        director,
        COUNT(*) AS movie_count
    FROM 
		netflix_data
    GROUP BY
		director
    HAVING 
		COUNT(*) >= 5
)
SELECT
    nd.director,
    nd.title AS title,
    nd.release_year
FROM 
	DirectorContent dc
INNER JOIN 
    netflix_data nd ON nd.director = dc.director
ORDER BY 
    nd.release_year ;


-- 3) Latest movies added to netflix

SELECT 
      title, 
      year(date_added2) as year
from 
	  netflix_data
where 
       year(date_added2) in ("2021", "2020");
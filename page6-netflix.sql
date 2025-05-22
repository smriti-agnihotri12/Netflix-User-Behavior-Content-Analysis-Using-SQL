-- gender wise preference of movies and tv shows

SELECT
    nud.gender,
    nd.type AS content_type,
    COUNT(*) AS preference_count

from netflix_user_data nud 
inner join netflix_data2_table nd2  on nud.user_id=nd2.user_id
inner JOIN netflix_data nd ON nd.show_id = nd2.show_id
GROUP BY nud.gender, nd.type
ORDER BY nud.gender, preference_count DESC;

-- 

select title, listed_in, gender
from netflix_data nd inner join netflix_data2_table nd2 using(show_id)
inner join netflix_user_data nu using(user_id);
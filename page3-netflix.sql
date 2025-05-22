-- Q3 Understanding User Behavior and Revenue Impact: 
-- Age Group Segmentation, Device Usage Analysis, and Rating Preferences on Netflix

-- 1) Determine the distribution of users across different age groups 
-- (e.g., 26-32, 33-39 etc.) and their average monthly revenue:

SELECT 
    CASE 
        WHEN age BETWEEN 26 AND 32 THEN '26-32'
        WHEN age BETWEEN 33 AND 38 THEN '33-39'
        WHEN age BETWEEN 40 AND 46 THEN '40-47'
        ELSE '>47'
    END AS 
        age_group,
		COUNT(*) AS user_count,
		ROUND(AVG(monthly_revenue),2) AS avg_monthly_revenue
FROM  
        netflix_user_data
GROUP BY 
        age_group;



  
-- Q2 B Analyze user viewing habits across different devices 

-- (it will help us to understand device preferences and optimize content qality delivery.
SELECT 
      device, 
      COUNT(*) AS usage_count
FROM
	  netflix_user_data
GROUP BY
	  device;





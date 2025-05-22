--1) What is the rating of the particular movie on Netflix?
DELIMITER //

CREATE PROCEDURE GetRatingOfMovie(IN chosenmovie VARCHAR(100))
BEGIN
    
    SELECT title, rating
    FROM netflix_data
    WHERE title = chosenmovie;
END //

DELIMITER ;


call GetRatingOfMovie("3 idiots");

--2) What is the average monthly revenue for each subscription type?
DELIMITER //

CREATE PROCEDURE GetAverageRevenueBySubscriptionType(in chosenSubstype varchar(100))
BEGIN
    SELECT subscription_type, AVG(monthly_revenue) AS avg_monthly_revenue
    FROM netflix_user_data
    where subscription_type=chosenSubstype
    GROUP BY subscription_type;
END //

call  GetAverageRevenueBySubscriptionType("premium");
-- 3) What shows has a specific user watched?
DELIMITER //

CREATE PROCEDURE GetShowsWatchedByUser(IN p_user_id INT)
BEGIN
    SELECT nd.title
    FROM netflix_data nd
    INNER JOIN netflix_data2_table nd2 ON nd.show_id = nd2.show_id
    WHERE nd2.user_id = p_user_id;
END //

DELIMITER ;

call GetShowsWatchedByUser(123938);

--4) What is the average monthly revenue generated from users of a specific gender and device type?

DELIMITER //

CREATE PROCEDURE GetAvgRevenueByGenderAndDevice(
    IN p_gender TEXT,
    IN p_device_type TEXT
)
BEGIN
    SELECT round(AVG(nud.monthly_revenue),2) AS avg_monthly_revenue
    FROM netflix_user_data nud
    INNER JOIN netflix_data2_table nd2 ON nud.user_id = nd2.user_id
    INNER JOIN netflix_data nd ON nd2.show_id = nd.show_id
    WHERE nud.gender = p_gender
        AND nud.device = p_device_type;
END //

DELIMITER ;

call GetAvgRevenueByGenderAndDevice("male","laptop");

create database netflix_database;

use netflix_database;

-- creating tables for database
CREATE TABLE netflix_data (
    show_id INT PRIMARY KEY,
    type text,
    title text,
    director text,
    cast text,
    country text,
    date_added text,
    release_year INT,
    rating text,
    duration text,
    listed_in text
);
CREATE TABLE netflix_user_data (
        user_id int ,
    show_id int,
   subscription_type text,
    monthly_revenue double,
    join_date text,
    last_payment_date text,
    user_country text,
    age INT,
    gender text,
    device text,
   constraint U_pk Primary key(user_id)
  
);
CREATE TABLE netflix_data2 (
        user_id int ,
    show_id int,
   Constraint D_fk1 FOREIGN KEY(show_id) REFERENCES netflix_data(show_id),
  Constraint U_fk1 FOREIGN KEY(user_id) REFERENCES netflix_user_data(user_id)
);


-- loading tables through cmd promt
LOAD DATA LOCAL INFILE 'E:\\_Ivy professional school\\SQL\\netflix_db\\netflix_data.csv'
     INTO TABLE netflix_data
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;


LOAD DATA LOCAL INFILE 'E:\\_Ivy professional school\\SQL\\netflix_db\\netflix_user_data.csv'
     INTO TABLE netflix_user_data
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
LINES TERMINATED BY '\r\n' IGNORE 1 ROWS;

set sql_safe_updates=0;
update netflix_data
set country=null
where country="";

set sql_safe_updates=0;
update netflix_data
set director=null
where director="";


alter table netflix_data
add column date_added2 date;
set sql_safe_updates=0;
UPDATE netflix_data
SET date_added2 = CASE
    WHEN INSTR(date_added, '-') > 0 THEN STR_TO_DATE(TRIM(date_added), '%d-%m-%y') 
    WHEN INSTR(date_added, ',') > 0 THEN STR_TO_DATE(TRIM(date_added), '%M %m, %Y') 
    ELSE NULL -- Default to NULL if the date format is unknown
END;


alter table netflix_user_data
add column join_date2 date ,
add column last_payment_date2 date;
set sql_safe_updates=0;
UPDATE netflix_user_data
SET join_date2 = CASE
    WHEN INSTR(join_date, '-') > 0 THEN STR_TO_DATE(TRIM(join_date), '%d-%m-%Y') 
    WHEN INSTR(join_date, '/') > 0 THEN STR_TO_DATE(TRIM(join_date), '%d/%m/%Y') 
    ELSE NULL 
END;
UPDATE netflix_user_data
SET last_payment_date2 = CASE
    WHEN INSTR(last_payment_date, '-') > 0 THEN STR_TO_DATE(TRIM(last_payment_date), '%d-%m-%Y') 
    WHEN INSTR(last_payment_date, '/') > 0 THEN STR_TO_DATE(TRIM(last_payment_date), '%d/%m/%Y') 
    ELSE NULL 
END;
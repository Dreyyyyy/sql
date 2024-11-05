-- Create table for January 2023
CREATE TABLE jan_23_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
    AND EXTRACT(YEAR FROM job_posted_date) = 2023;

-- Create table for February 2023
CREATE TABLE feb_23_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2
    AND EXTRACT(YEAR FROM job_posted_date) = 2023;

-- Create table for March 2023
CREATE TABLE mar_23_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3
    AND EXTRACT(YEAR FROM job_posted_date) = 2023;

SELECT * 
FROM jan_23_jobs
LIMIT 5;
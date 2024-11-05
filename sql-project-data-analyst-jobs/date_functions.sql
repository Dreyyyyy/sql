/*
Write a query to find the average salary both yearly(salary_year_avg)
and hourly (salary_hour_avg) for job postings that were posted after June 1, 2023.
Group the results by job schedule type.
*/

SELECT
    job_schedule_type,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary_yearly,
    ROUND(AVG(salary_hour_avg), 2) AS avg_salary_hourly
FROM
    job_postings_fact
WHERE
    job_posted_date > '2023-06-01'
GROUP BY
    job_schedule_type;

/*
Write a query to count the number of job postings for each month in 2023,
adjusting the job_posted_date to be in 'America/New_York' time zone before
before extracting (hint) the month. Assume the job_posted_date is stored in UTC.
Group by and order by the month.
*/
SELECT
    EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') AS month,
    COUNT(*) AS num_job_postings
FROM
    job_postings_fact
WHERE
    EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY
    month
ORDER BY
    month;

/*
Write a query t find companies (include company name) that have posted jobs
offering health insurance, where these postings were made in the second quarter
of 2023. Use date extraction to filter by quarter.
*/

SELECT * FROM company_dim
LIMIT 5;

SELECT * FROM job_postings_fact
LIMIT 5;

SELECT
    company_dim.name,
    COUNT(*) AS num_job_postings
FROM
    company_dim
JOIN
    job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_health_insurance = 'True'
    AND EXTRACT(QUARTER FROM job_posted_date) = 2
    AND EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY
    company_dim.name;

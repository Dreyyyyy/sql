SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;

/*
Categorize the salaries from each job posting. To see if it fits
my desired salary range.
    * Put salary into different buckets;
    * Define what's a high, standard or low salary with our own cconditions;
    * I only want to look at data analyst roles;
    * Order from highest to lowest.
*/

SELECT 
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 90000 THEN 'low'
        WHEN salary_year_avg BETWEEN 90000 AND 120000 THEN 'standard'
        WHEN salary_year_avg > 120000 THEN 'high'
    END AS salary_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
  AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;
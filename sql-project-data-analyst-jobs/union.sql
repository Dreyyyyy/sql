-- Get jobs and companies from January
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    jan_23_jobs

UNION ALL

-- Get jobs and companies from February
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    feb_23_jobs

UNION ALL

-- Get job and companies from March
SELECT
    job_title_short,
    company_id,
    job_location
FROM
    mar_23_jobs

/*
Practice Problem 1
Get the corresponding skill and skill type for each job posting in q1
Includes those without any skills too
Look at the skills and the type for each job in the first quarter that has a salary > $70,000
*/
SELECT *
FROM job_postings_fact
LIMIT 10;

SELECT * 
FROM skills_dim
LIMIT 10;

SELECT *
FROM skills_job_dim
LIMIT 10;

SELECT 
    job_postings_fact.job_id,
    skills_dim.skill_id,
    skills_dim.skills,
    skills_dim.type
FROM job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.salary_year_avg > 70000 AND
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) IN (1, 2, 3) -- Filter just for Q1

UNION

SELECT 
    job_postings_fact.job_id,
    skills_dim.skill_id,
    skills_dim.skills,
    skills_dim.type
FROM job_postings_fact
INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.salary_year_avg <= 70000 AND
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) IN (1, 2, 3) -- Filter just for Q1

/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Get job postings with an average yearly salary > 70K
*/
SELECT 
    job_postings_Q1.job_title_short,
    job_postings_Q1.job_location,
    job_postings_Q1.job_via,
    job_postings_Q1.job_posted_date::DATE 
    FROM(
        SELECT *
        FROM jan_23_jobs
        UNION ALL
        SELECT *
        FROM feb_23_jobs
        UNION ALL
        SELECT *
        FROM mar_23_jobs
    ) AS job_postings_Q1
WHERE job_postings_Q1.salary_year_avg > 70000;


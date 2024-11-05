SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
        company_id
    FROM
        job_postings_fact
    WHERE
        job_no_degree_mention = true
);

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT company_dim.name AS company_name,
       company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC

/*
Identify the top 5 skills that are most frequently mentioned in job postings. Use a
subquery to find the skill IDs with the highest counts in the skills_job_dim table and then
join this results with the skills_dim table to get the skill names.
*/

SELECT *
FROM job_postings_fact
LIMIT 10;

SELECT *
FROM skills_job_dim
LIMIT 10;

SELECT *
FROM skills_dim
LIMIT 10;

WITH top_skills AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim
    GROUP BY
        skill_id
    ORDER BY
        skill_count DESC
)

SELECT
    skills_dim.skills AS skill_name,
    top_skills.skill_count
FROM
    top_skills
JOIN
    skills_dim ON top_skills.skill_id = skills_dim.skill_id
LIMIT 5;

/*
Determine the size category('Small', 'Medium', or 'Large') of each company by first
identifying the number of job postings they have. Use a subquery to calculate the
total job postings per company. A company is considered 'Small' if it has less than
50 job postings. Implement a subquery to aggregate job counts per company before
classifiying them based on size.
*/

-- CTE to calculate total jobs for each company
WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

-- Main query to join with company_dim and categorize company size
SELECT
    company_dim.name AS company_name,
    company_job_count.total_jobs,  -- Added comma here
    CASE
        WHEN company_job_count.total_jobs < 50 THEN 'Small'
        WHEN company_job_count.total_jobs < 100 THEN 'Medium'
        ELSE 'Large'
    END AS size_category
FROM
    company_dim
LEFT JOIN
    company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC;

/*
Find the count of the number of remote jobs postings per skill
 - Display the top 5 skills by their demand in remote jobs
 - Include skill ID, name, and count of postings requiring the skill
*/

WITH remote_jobs_counting AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(*) AS remote_jobs_count
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE AND
        job_postings_fact.job_title_short = 'Data Analyst'

    GROUP BY
        skills_dim.skill_id
)

SELECT
    remote_jobs_counting.skill_id,
    remote_jobs_counting.skills,
    remote_jobs_counting.remote_jobs_count
FROM
    remote_jobs_counting
ORDER BY
    remote_jobs_count DESC
LIMIT 5;


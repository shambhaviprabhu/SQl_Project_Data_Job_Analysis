-- Case Statement
/* Label new Column as follows:
- "Anywhere"jobs as "Remote"
- "Newyork ,NY " jobs as "Local"
- Other jobs as "Onsite" */


SELECT job_title_short ,
       job_location,
       CASE
           WHEN job_location = 'Anywhere' THEN 'Remote'
           WHEN job_location = 'New York, NY' THEN 'Local'
           ELSE 'Onsite'
       END AS location_category
FROM job_postings_fact;

-- Count of Remote jobs 

SELECT 
    count(job_id) AS Job_Count ,
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


/* Question :
I want to categorize the salaries from each job posting.
- Put salary into different buckets
- Define whats high ,standard , low salary with our conditions.
-I only want to consider Data Analyst positions.
- order from highest to lowest salary.*/

-- Calucated the average_salary , Min & Max Salary for Data Analysts.
SELECT
     AVG(salary_year_avg) AS avg_salary,
     MIN(salary_year_avg) AS min_salary,
     MAX(salary_year_avg) AS max_salary

FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst';


-- Categorize Jobs based on Salary for Data Analyst Positions

SELECT 
    job_title_short,
    salary_year_avg AS salary,
    CASE
       WHEN salary_year_avg IS NULL THEN 'Not Listed'
       WHEN salary_year_avg > 100000 THEN 'High'
       WHEN salary_year_avg BETWEEN 60000 AND 100000 THEN 'Standard'
       ELSE 'Low'
    END AS salary_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC;

-- Count of Jobs in different Categories.

    SELECT 
        CASE
            WHEN salary_year_avg IS NULL THEN 'Not Listed'
            WHEN salary_year_avg > 100000 THEN 'High'
            WHEN salary_year_avg BETWEEN 60000 AND 100000 THEN 'Standard'
            ELSE 'Low'
        END AS salary_category,
        COUNT(job_title_short) AS job_count
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND
        salary_year_avg IS NOT NULL
    GROUP BY
        CASE
            WHEN salary_year_avg IS NULL THEN 'Not Listed'
            WHEN salary_year_avg > 100000 THEN 'High'
            WHEN salary_year_avg BETWEEN 60000 AND 100000 THEN 'Standard'
            ELSE 'Low'
        END;

        
    

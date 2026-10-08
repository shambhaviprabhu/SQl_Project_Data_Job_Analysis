/* 
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely.
- Focuses on job postings with specified salaries(remove nulls).
- Why? Highlight the Top paying oppourtunities  for Data Analyst , offering insights into 
*/

SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        job_posted_date::DATE AS posting_date,
        name as company_name,
        salary_year_avg
FROM 
        job_postings_fact
LEFT JOIN
         company_dim  ON company_dim.company_id = job_postings_fact.company_id 
WHERE   job_location = 'Anywhere'
And     salary_year_avg IS NOT NULL
AND     job_title_short = 'Data Analyst'
Order by   
        salary_year_avg   Desc
LIMIT 10     ;   
         


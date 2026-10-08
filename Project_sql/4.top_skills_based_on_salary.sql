/* Question:
What are the top skills based on salary?
Look at the average salary associated with each skill for Data Analyst positions
Focuses on roles with specified salaries, regardless of location
Why ? It reveals how different skills impact salary levels for Data Analyst and help 
identify the most financially rewarding skills to acquire and improve.*/

SELECT
    sd.skills,
    ROUND(avg(jpf.salary_year_avg),2) as Avg_salary
FROM    
    job_postings_fact jpf
INNER Join     skills_job_dim  sjd  ON sjd.job_id = jpf.job_id
INNER JOIN     skills_dim sd  ON  sd.skill_id = sjd.skill_id
WHERE job_title_short = 'Data Analyst' AND 
      salary_year_avg IS NOT NULL
GROUP BY
        sd.skills
ORDER BY   Avg_salary DESC
LIMIT 25;    
/* Question:
What are the most in demand skills for data analyst?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in demand skills for data analyst
-Focus on all job postings
- Why ? retrieves the top 5 skills with the highest demand in job market,
providing insights into the most valuable skills for the job seekers.*/


WITH Job_count_Data_Analyst As(
    SELECT  
            sd.skill_id,
            sd.skills,
            count(jpf.job_id) as Job_count_Data_Analyst
    FROM
            job_postings_fact jpf
    INNER JOIN   skills_job_dim sjd ON sjd.job_id = jpf.job_id
    INNER JOIN   skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE
            job_title_short = 'Data Analyst'
    GROUP BY
            sd.skill_id,
            sd.skills      
   
   ),

Job_Count_Data_Analyst_Remote AS (
SELECT  
            sd.skill_id,
            sd.skills,
            count(jpf.job_id) as Job_count_DA_Remote
    FROM
            job_postings_fact jpf
    INNER JOIN   skills_job_dim sjd ON sjd.job_id = jpf.job_id
    INNER JOIN   skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE
            job_title_short = 'Data Analyst' AND
            job_work_from_home = True
    GROUP BY
            sd.skill_id,
            sd.skills      
  )

SELECT
        da.skills,
        da.Job_count_Data_Analyst,
        dar.Job_count_DA_Remote
FROM    Job_count_Data_Analyst da
LEFT JOIN   Job_Count_Data_Analyst_Remote dar on dar.skill_id = da.skill_id 
ORDER BY  Job_count_Data_Analyst DESC
LIMIT 5;


/* Question:
What are the most optimal skills to learn(aka its in demand and high paying skill)?
-Identify the skills in high demand and associated with high average salaries for Data analyst roles
-Concentrate on remote positions with specified salaries 
Why ? Targets skills that offer job security (high demand) and finacial benifits (high salaries),
offering strategic insights for career development in data analytics. */


WITH Job_count_Data_Analyst As(
    SELECT  
            sd.skill_id,
            sd.skills AS Skills_In_Demand,
            count(jpf.job_id) as Job_count_Data_Analyst
    FROM
            job_postings_fact jpf
    INNER JOIN   skills_job_dim sjd ON sjd.job_id = jpf.job_id
    INNER JOIN   skills_dim sd ON sd.skill_id = sjd.skill_id
    WHERE
            job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL AND
            job_work_from_home = True
    GROUP BY
            sd.skill_id,
            sd.skills 
    
   ),

top_paying_skills AS(
    SELECT
        sd.skills AS High_Paying_Skills,
        sd.skill_id ,
        ROUND(avg(jpf.salary_year_avg),0) as Avg_salary
    FROM    
        job_postings_fact jpf
    INNER Join     skills_job_dim  sjd  ON sjd.job_id = jpf.job_id
    INNER JOIN     skills_dim sd  ON  sd.skill_id = sjd.skill_id
    WHERE job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL AND
        job_work_from_home = True
    GROUP BY
            sd.skill_id,
            sd.skills
    )

 SELECT 
        jcda.Skills_In_Demand,
        jcda.Job_count_Data_Analyst,
        tps.Avg_salary
FROM Job_count_Data_Analyst jcda
INNER JOIN top_paying_skills tps ON tps.skill_id = jcda.skill_id
WHERE Job_count_Data_Analyst > 12 
ORDER BY 
        tps.Avg_salary DESC,
        jcda.Job_count_Data_Analyst DESC  
Limit 25; 






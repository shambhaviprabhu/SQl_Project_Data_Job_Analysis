-- CTE Common Table Expression
/* Find the companies that have the most job openings.
- Get the total number of job postings per company id.
- Return the total number of jobs with the company name. */

WITH Company_Job_Counts AS (
    SELECT
        jpf.company_id,
        cd.name AS company_name,
        Count(job_title_short)as Count_of_Job_Postings
    FROM  
         job_postings_fact jpf 
    LEFT Join company_dim cd ON cd.company_id = jpf.company_id
    GROUP BY 
        jpf.company_id,
        cd.name )

SELECT 
    company_name,
    Count_of_Job_Postings
FROM 
    Company_Job_Counts 
ORDER By Count_of_Job_Postings desc;


/*Determine the size category ("Small","Medium","Large")for each company by first 
identifying the number of jobs postings they have.Use a subquery to calculate the total job 
potings per company. A company is considered small if it has less than 10 jobs postings,
"medium"if the job postings are between 10 & 50 and "large" if more than 50.
Implement a subquerry to aggreagate job counts per country before classsifyng them 
based on the size.*/



WITh Job_counts AS(
SELECT
        cd.name As Company_name,
        count(jpf.job_id) AS Job_counts
FROM         
        job_postings_fact jpf
LEFT JOIN
        company_dim cd ON cd.company_id = jpf.company_id 
GROUP BY 
       cd.name)  

SELECT
       Company_name,
       CASE
          WHEN Job_counts < 10 Then 'Small Company'
          When Job_counts BETWEEN 10 AND 50 THEN 'Medium Company'
          Else 'Large Company'
       End As Company_Categories
FROM    
        Job_counts;




/* Find the Count of the number of remote jobs postings per skill
- Display the top 5 skills by their demand in remote jobs
- Include Skill ID ,name , count of postings requiring the skill */

SELECT
      sd.skill_id,
      sd.skills,
      count(jpf.job_id) As Count_Remote_Jobs
FROM
      job_postings_fact jpf
LEFT JOIN     skills_job_dim sjd ON sjd.job_id  = jpf.job_id
LEFT JOIN     skills_dim sd on sd.skill_id = sjd.skill_id
WHERE 
      jpf.job_work_from_home = TRUE
AND 
      jpf.job_title_short = 'Data Analyst'      
GROUP BY
        sd.skill_id,
        sd.skills
ORDER BY Count_Remote_Jobs DESC
LIMIT 5 ;



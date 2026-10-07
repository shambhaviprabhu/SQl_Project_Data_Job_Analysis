/* Get the corresponding skill and skill type for each job posting in qt1
Include those without any skils too
Why ? Look at the skills and the type for each job in the first quater that a salary> $70000*/

Select * from skills_dim;

Select 
        jpf.job_title_short,
        sd.skill_id,
        sd.skills,
        sd.type AS Skill_type

FROM
        job_postings_fact jpf
LEFT JOIN 
        skills_job_dim  sjd ON sjd.job_id = jpf.job_id    
LEFT JOIN
        skills_dim sd    ON sd.skill_id = sjd.skill_id
WHERE 
        EXTRACT(YEAR FROM jpf.job_posted_date)= 2023
AND        
        EXTRACT(QUARTER FROM jpf.job_posted_date)= 1
AND 
        jpf.salary_year_avg > 70000        ;



/* Find Job postings from 1st quater that have a salary greater than 70k
- Combine job posting tables from first quarter of 2023 
- Gets job postings with an average yearly salary > $70000 */

SELECT
        job_title_short,
        job_posted_date::DATE as date,
        EXTRACT(MONTH FROM job_posted_date) AS month
FROM    job_postings_fact
WHERE      
        EXTRACT(QUARTER FROM job_posted_date) = 1
AND      salary_year_avg   >70000
ORDER BY 
        job_posted_date::DATE;

-- Alternate Solution Using Union


SELECT
        job_title_short,
        job_location,
        job_posted_date::DATE as Job_posted_Date,
        salary_year_avg   
FROM(

SELECT *        
FROM jan2023_jobs
UNION ALL
SELECT *        
FROM feb2023_jobs
UNION ALL
SELECT *        
FROM Mar2023_jobs) AS Quater1_Jobs
WHERE
      salary_year_avg   >70000
AND   job_title_short  = 'Data Analyst'
ORDER BY  salary_year_avg DESC ;   
SELECT
        company_id,
        name AS Company_Name
        
FROM         
        company_dim
Where company_id IN
      ( SELECT 
                company_id      
        FROM
                job_postings_fact
        WHERE 
                job_no_degree_mention = TRUE);                 


/*Identify top5 skills that are most frequently mentioned in Job Postings.
Use a subquerry to find the skill ids with highest counts in the skills_job_dim.
table and then join the result with the skills_dim table to get the skils name.*/

SELECT
      skills
FROM  
      skills_dim
WHERE 
       skill_id IN (
                    SELECT
                        skill_id
                     FROM  
                          skills_job_dim
                    GROUP BY skill_id    
                    ORDER BY count(job_id) DESC   
                    LIMIT 5   
                    ) 
                 ; 

SELECT DISTINCT
      sd.skills
FROM  
      skills_job_dim AS skd
LEFT JOIN 
      skills_dim sd on sd.skill_id = skd.skill_id
WHERE       
       skd.skill_id IN (
                    SELECT
                        skill_id
                     FROM  
                          skills_job_dim
                    GROUP BY skill_id    
                    ORDER BY count(job_id) DESC   
                    LIMIT 5   
                    ) 
                 ; 

/*Determine the size category ("Small","Medium","Large")for each company by first 
identifying the number of jobs postings they have.Use a subquery to calculate the total job 
potings per company. A company is considered small if it has less than 10 jobs postings,
"medium"if the job postings are between 10 & 50 and "large" if more than 50.
Implement a subquerry to aggreagate job counts per country before classsifyng them 
based on the size.*/

SELECT 
        cd.name As Company_name, 
        CASE 
                WHEN count(jpf.job_id)< 10 THEN 'Small' 
                WHEN count(jpf.job_id) Between 10 AND 50 THEN 'Medium'
                ELse 'Large' 
                End As Company_classification
FROM
        job_postings_fact jpf
LEFT JOIN
        company_dim cd ON cd.company_id = jpf.company_id
GROUP BY      
        cd.name;          





-- Alternate Solution

SELECT
    cd.name AS Company_name,
    CASE
        WHEN company_job_count < 10 THEN 'Small'
        WHEN company_job_count BETWEEN 10 AND 50 THEN 'Medium'
        ELSE 'Large'
    END AS Company_classification
FROM company_dim cd
LEFT JOIN (
    SELECT
        company_id,
        COUNT(job_id) AS company_job_count
    FROM job_postings_fact
    GROUP BY company_id
) AS company_counts
    ON cd.company_id = company_counts.company_id;

    
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

SELECT job_id,
       job_title_short,
       EXTRACT(YEAR from job_posted_date) as year,
       TO_CHAR(job_posted_date, 'Month') AS month
FROM   job_postings_fact
WHERE EXTRACT(YEAR from job_posted_date) = 2023
AND   EXTRACT(MONTH from job_posted_date) IN (1,2,3); 
 
/* Create table from Other Table
 Create 3 tables:
  1) Jan2023 Jobs
  2) Feb2023 Jobs
  3) Mar2023 Jobs */


-- Checked the Dates Column to confirm that the date range.
SELECT DISTINCT
       EXTRACT(YEAR from job_posted_date) as year,
       EXTRACT(MONTH from job_posted_date) as month

FROM   job_postings_fact
ORDER BY Year, Month;


CREATE TABLE Jan2023_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(YEAR from job_posted_date) = 2023
    AND EXTRACT(MONTH from job_posted_date) = 1 ;


CREATE TABLE Feb2023_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(YEAR from job_posted_date) = 2023
    AND EXTRACT(MONTH from job_posted_date) = 2 ;

CREATE TABLE Mar2023_Jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(YEAR from job_posted_date) = 2023
    AND EXTRACT(MONTH from job_posted_date) = 3 ;


Select * from jan2023_jobs;
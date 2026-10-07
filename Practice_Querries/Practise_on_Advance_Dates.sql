SELECT COUNT(*) FROM company_dim;



SELECT COUNT(*) FROM job_postings_fact;


SELECT COUNT(*) FROM skills_job_dim;

Select * FROM job_postings_fact
Limit 100;

Select job_posted_date from job_postings_fact
Limit 10;

Select '2023-09-25'::Date,
        '123'::Integer,
        'true'::Boolean,
        'false'::Boolean,
        '3.14'::Real;

SELECT job_title_short as title,
       job_location as location,
       job_posted_date::Date as posted_date
FROM
        job_postings_fact;


SELECT job_title_short as title,
       job_location as location,
       job_posted_date At time Zone 'UTC' AT time Zone 'EST' as time_date
FROM
        job_postings_fact;

SELECT job_title_short as title,
       job_location as location,
       job_posted_date::Date as  posted_date,
       EXTRACT(MONTH FROM job_posted_date) as month
FROM
        job_postings_fact;

-- Write a query to find the average salary both yearly and hourly for job postings after June1,2023

SELECT job_schedule_type,
       AVG(salary_year_avg) as avg_yearly_salary,
       AVG(salary_hour_avg) as avg_hourly_salary
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

/* Write a querry to count number of job postings for each month in 2023 ,adjusting for timezone
job_posted_date to be in "America/New_York"time zone before extracting the month.
Assume job posted date is stored in UTC timezone.
group by and order by month./*


SELECT  COUNT(*) as job_posting_count,
        EXTRACT(MONTH FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') as month
       
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York') = 2023
GROUP BY month
ORDER BY month;



/* Write a querry to find companies(include companies name)that have
posted jobs offering health insurance, where these postings were made in the
second quarter 2023 . Use date extraction to filter by quater.  /*

SELECT cd.name,
       jpf.job_health_insurance
FROM  job_postings_fact as jpf
JOIN company_dim cd ON jpf.company_id = cd.company_id
WHERE jpf.job_health_insurance = true
  AND EXTRACT(QUARTER FROM jpf.job_posted_date 
                AT TIME ZONE 'UTC' 
                AT TIME ZONE 'America/New_York') = 2
  AND EXTRACT(YEAR FROM jpf.job_posted_date 
                AT TIME ZONE 'UTC' 
                AT TIME ZONE 'America/New_York') = 2023;
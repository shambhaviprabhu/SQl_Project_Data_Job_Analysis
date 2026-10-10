# Introduction
📊 Dive into the data job market!Focusing on data analyst roles, this project explores top paying jobs 💰, in-demand skills 🛠️ and📈 where high demand meets high salary in data analyst.

🔍SQL Queries? Check them out here:  [Project_sql folder](/Project_sql/)

# Background
Driven by the quest to navigate the data analyst job market more effectively, this project was born from desire to pinpoint top-paid and in-demand skills , streamlining others work to find optimal jobs.

### The questions I wanted to answer through SQL queries were:
1. What are the top-paying data analyst jobs?
2. What skills are required for these top paying jobs?
3. What skills are most in demand for data analyst?
4. Which skills are associated with higher salaries?
5. Which are the most optimal skills to learn?

## Dataset source
CSV datasets used
1. skills_job_dim.csv
2. company_dim.csv
3. job_postings_fact.csv
4. skills_dim.csv


All csv datasets were downloaded from https://sql.lukebarousse.com/#/workspace
1. Click Run SQL query button on the right panel to run the query to obtain data results
2. Click Export result to CSV to download file.


# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQl:** The backbone of my analysis , allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual studio Code:** My go-to for database management and executing SQl queries.
- **Git & GitHub:** Essential for version control and sharing my SQl scripts and analysis,ensuring collaboration and project tracking.   

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles,I filtered data analyst positions by average yearly salary and location,focusing on remote jobs.This query highlights the high paying opportunities in the field.

```sql
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
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range :** Top 10 paying data analyst roles span from $184000 to $650000 , indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta , and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There is high variety of job titles , from Data Analyst to Director of Analytics,reflecting varied roles and specilizations with data analytics.

### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skill data, providing insights into what employers value for high compension roles.
```sql
With top_paying_jobs AS(
    SELECT
            job_id,
            job_title,
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
    LIMIT 10 )     
      
SELECT
      top_paying_jobs.*,
      skills_dim.skills
FROM  top_paying_jobs
INNER JOIN  skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN  skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:

- **SQl** is leading with a bold count of 8
- **Python** follows closely with a count of 7
- **Tableau** is also highly sought after , with a count of 6 . Other skills like **snowflake**,**R** ,**Pandas** and **Excel** show varying degrees of demand.

### 3. In Demand Skills for Data Analyst
The query helped identify the skills most frequently requested in job postings, directing focus to areas in high demand.
```sql
WITH Job_count_Data_Analyst As(
    SELECT  
            sd.skill_id,
            sd.skills,
            count(jpf.job_id) as Jobs_Data_Analyst
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
            count(jpf.job_id) as Jobs_Data_Analyst_Remote
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
        da.Jobs_Data_Analyst,
        dar.Jobs_Data_Analyst_Remote
FROM    Job_count_Data_Analyst da
LEFT JOIN   Job_Count_Data_Analyst_Remote dar on dar.skill_id = da.skill_id 
ORDER BY  Jobs_Data_Analyst DESC
LIMIT 5;
```

Here's breakdown of the most demanded skills for data analyst in 2023:
- **Sql** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**,**Tableau**,and **Power BI** are essential , pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skill    | Data Analyst Jobs | Remote Data Analyst Jobs |
| -------- | ----------------: | -----------------------: |
| SQL      |            92,628 |                    7,291 |
| Excel    |            67,031 |                    4,611 |
| Python   |            57,326 |                    4,330 |
| Tableau  |            46,554 |                    3,745 |
| Power BI |            39,468 |                    2,609 |



### 4. Skills Based On Salary
This analysis identifies the **top 25 skills associated with the highest average salaries** for Data Analyst positions with reported salaries, regardless of location.
```sql
SELECT
    sd.skills,
    ROUND(avg(jpf.salary_year_avg),0) as Avg_salary
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
```   
The results show that specialized technical skills tend to be associated with higher salaries. SVN has the highest average salary at $400,000, followed by Solidity ($179,000), Couchbase ($160,515), DataRobot ($155,486), and Golang ($155,000). Other high-paying skills include machine learning frameworks such as PyTorch, TensorFlow, Keras, and MXNet, as well as technologies such as Kafka, Terraform, and Airflow.
Overall, the results suggest that specialized programming, machine learning, cloud, and data-engineering skills can be associated with higher salary levels.

### 5. Optimal Skills to Learn
This query identifies the most in-demand skills among remote Data Analyst job postings and compares them based on their average salary.
```sql
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
```
| Skill      | Data Analyst Jobs | Average Salary |
| ---------- | ----------------: | -------------: |
| Go         |                27 |       $115,320 |
| Hadoop     |                22 |       $113,193 |
| Snowflake  |                37 |       $112,948 |
| Azure      |                34 |       $111,225 |
| BigQuery   |                13 |       $109,654 |
| AWS        |                32 |       $108,317 |
| Java       |                17 |       $106,906 |
| Jira       |                20 |       $104,918 |
| Oracle     |                37 |       $104,534 |
| Looker     |                49 |       $103,795 |
| NoSQL      |                13 |       $101,414 |
| Python     |               236 |       $101,397 |
| R          |               148 |       $100,499 |
| Redshift   |                16 |        $99,936 |
| Qlik       |                13 |        $99,631 |
| Tableau    |               230 |        $99,288 |
| SSRS       |                14 |        $99,171 |
| Spark      |                13 |        $99,077 |
| SAS        |                63 |        $98,902 |
| SQL Server |                35 |        $97,786 |
| JavaScript |                20 |        $97,587 |
| Power BI   |               110 |        $97,431 |
| SQL        |               398 |        $97,237 |
| Flow       |                28 |        $97,200 |

The results show that **SQL**, **Python**, **Tableau**, **Power BI**, and **R** are among the most frequently requested skills, with SQL appearing in 398 postings, Python in 236, Tableau in 230, Power BI in 110, and R in 148. These results highlight the continued importance of core data analytics and business intelligence skills in the remote job market.

At the same time, some less frequently requested skills offer higher average salaries. For example, Go, Hadoop, Snowflake, Azure, and BigQuery have relatively fewer postings but average salaries above $109,000. This suggests that specialized technical skills may command higher salaries even when their overall demand is lower.

Overall, the analysis demonstrates that high demand does not always correspond to the highest salary. For someone preparing for a Data Analyst career, developing strong foundational skills such as SQL, Python, Tableau, and Power BI, while adding specialized cloud and data-platform skills, can help balance job-market demand with earning potential.





# Conclusion
### Insights
From the analysis , several general insights emerged:
1. **Top-Paying Data Analyst Jobs :** The highest-paying jobs for data analyst that allow remote work offer a wide range of salaries, the highest at $650000.
2. **Skills For Top Paying Jobs:** High-paying data analyst jobs require advanced proficiency in SQl, suggesting its critical skill for earning top salary. 
3. **Most In Demand Skills:** SQl is also the most in demand skill in data analyst job market, thus making it essential for job seekers.
4. **Skills With higher salaries:** Specilized skills, such as SVN and Solidity, are associated with the highest average salaries ,indicating a premium on niche expertise. 
5. **Optimal Skills for Job Market:** SQL leads in demand and offers  for a high average salary, positioning it as one of the most optimal skills for data anlysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my sql skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts.Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills.This exploration highlights the importance of continuous learning and adaptation of emerging trends in the field of data analytics.

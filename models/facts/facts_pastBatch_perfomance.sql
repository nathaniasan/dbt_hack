{{ config(materialized='table') }}

WITH facts_PastBatch AS (
    SELECT 
        s.student_id AS id_dim_student,
        i.instructor_id AS id_dim_instructor,
        b.id AS id_dim_batch,
        d.id AS id_dim_date,
        w.id AS id_dim_week,
        ct.id AS id_dim_challenge_type,
        p.Score AS score,
        p.Weekly_Status AS weekly_status,
        p.Status AS `status`
    FROM 
        staging_1.past_batch p
    LEFT JOIN 
        staging_1.dim_student s ON p.Name = s.student_name
    LEFT JOIN 
        staging_1.dim_instructor i ON p.Buddy = i.instructor_name
    LEFT JOIN 
        staging_1.dim_batch b ON CAST(p.Batch AS STRING) = b.Batch 
                             AND p.Location = b.Location 
                             AND p.Phase = b.Phase
    LEFT JOIN 
        staging_1.dim_date d ON p.`Date of Enrollment` = d.date_enrollment
    LEFT JOIN 
        staging_1.dim_week w ON p.Week = w.week_name
    LEFT JOIN 
        staging_1.dim_ct ct ON p.Challenge_Type = ct.challenge_type
)

SELECT 
    
    id_dim_student,
    id_dim_instructor,
    id_dim_batch,
    id_dim_date,
    id_dim_week,
    id_dim_challenge_type,
    score,
    weekly_status,
    `status`
FROM 
    facts_PastBatch

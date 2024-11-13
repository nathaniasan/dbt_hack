{{ config(materialized='table') }}

WITH facts_CurrentBatch AS (
    SELECT 
        ROW_NUMBER() OVER (ORDER BY n.Name) AS factCurrent_id, -- Unique ID for the fact table
        s.student_id AS id_dim_student,
        i.instructor_id AS id_dim_instructor,
        b.id AS id_dim_batch,
        d.id AS id_dim_date,
        w.id AS id_dim_week,
        ct.id AS id_dim_challenge_type,
        n.Score AS score,
        n.Score_persen AS score_persen,
        n.Weekly_Status AS weekly_status,  -- Added missing comma here
        n.Weekly_Cat AS weekly_category,
        n.Status AS `status`

    FROM 
        staging_1.new_batch n
    LEFT JOIN 
        staging_1.dim_student s ON n.Name = s.student_name
    LEFT JOIN 
        staging_1.dim_instructor i ON n.Buddy = i.instructor_name
    LEFT JOIN 
    `staging_1.dim_batch` b ON CAST(n.Batch AS STRING) = b.Batch 
                                 AND n.Location = b.Location 
                                 AND n.Phase = b.Phase -- Single join using all columns
    LEFT JOIN 
       `staging_1.dim_date` d ON n.`Date_of_Enrollment` = d.date_enrollment -- Match enrollment date to ID
    LEFT JOIN 
        staging_1.dim_week w ON n.Week = w.week_name
    LEFT JOIN 
        staging_1.dim_ct ct ON n.Challenge_Type = ct.challenge_type
)

SELECT 
    factCurrent_id, 
    id_dim_student,
    id_dim_instructor,
    id_dim_batch,
    id_dim_date,
    id_dim_week,
    id_dim_challenge_type,
    score,
    weekly_status,
    `status`

FROM facts_CurrentBatch

{{ config(materialized='table') }}


with stg_student as (
    select distinct `Name` as student_name
    FROM staging_1.all_batch
    where `Name` is not null
    and `Name` != '#REF!'                -- Exclude "#REF!" values
    and `Name` != '-'  
    
)

select row_number() over (order by `student_name`) as student_id, student_name
from stg_student
 

{{ config(materialized='table') }}


with stg_instructor as (
    select distinct Buddy as instructor_name
    FROM staging_1.all_batch
    where Buddy is not null
    and Buddy != '#REF!'                -- Exclude "#REF!" values dari data staging
      and Buddy != '-'  
)

select row_number() over (order by `instructor_name`) as instructor_id, instructor_name
from stg_instructor
 

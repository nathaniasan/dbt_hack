{{ config(materialized='table') }}


with stg_week as (
    select distinct `Week` as week_name
    FROM staging_1.all_batch
    where `Week` is not null
    and `Week` != '#REF!'                -- Exclude "#REF!" values
    and `Week` != '-'  
    
)

select row_number() over (order by `week_name`) as id, week_name
from stg_week
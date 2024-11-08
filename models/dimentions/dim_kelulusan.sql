{{ config(materialized='table') }}


with stg_weekly_status as (
    select distinct `Weekly_Status` as weekly_status_name
    FROM staging_1.all_batch
    where `Weekly_Status` is not null
    and `Weekly_Status` != '#REF!'                -- Exclude "#REF!" values
    and `Weekly_Status` != '-'  
    
)

select row_number() over (order by `weekly_status_name`) as id, weekly_status_name
from stg_weekly_status
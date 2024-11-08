
{{ config(materialized='table') }}


with stg_ct as (
    select distinct `Challenge_Type` as challenge_type
    FROM staging_1.all_batch
    where `Challenge_Type` is not null
    and `Challenge_Type` != '#REF!'                -- Exclude "#REF!" values
    and `Challenge_Type` != '-'  
    
)

select row_number() over (order by `challenge_type`) as id, challenge_type
from stg_ct



 

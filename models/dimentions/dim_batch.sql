{{ config(materialized='table') }}

with stg_batch as (
    select 
        distinct 
        cast(Batch as STRING) as Batch,   -- Convert Batch to STRING to ensure consistent data types
        cast(Phase as STRING) as Phase, 
        cast(Location as STRING) as Location
    from 
        staging_1.all_batch
    where 
        Batch is not null 
        and Batch != 0                -- Exclude invalid values
        and Batch != -1 
)

select 
    row_number() over (order by Batch, Phase, Location) as id,  -- Generate a unique ID for each combination
    Batch, 
    Phase, 
    Location
from 
    stg_batch

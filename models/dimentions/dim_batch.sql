with stg_batch as (
    select distinct Batch as combined_value, 'Batch' as source
    FROM staging_1.all_batch
    where Batch is not null
    and Batch != '#REF!'                
    and Batch != '-'  

    UNION ALL

    select distinct Phase as combined_value, 'Phase' as source
    FROM staging_1.all_batch
    where Phase is not null
    and Phase != '#REF!'                
    and Phase != '-'  

    UNION ALL

    select distinct Location as combined_value, 'Location' as source
    FROM staging_1.all_batch
    where Location is not null
    and Location != '#REF!'                
    and Location != '-'  
)

select row_number() over (order by combined_value) as id, combined_value, source
from stg_batch
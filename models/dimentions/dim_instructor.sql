
{{ config(materialized='table') }}

select distinct
    Buddy as instructor_name
from {{ ref('staging_1.all_batch') }}
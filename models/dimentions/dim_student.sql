-- models/dimensions/dim_peserta.sql
{{ config(materialized='table') }}

select distinct
    Name as peserta_name
from {{ ref('staging_1.all_batch') }}

{{ config(materialized='table') }}

with stg_date as (
    select distinct `Date_of_Enrollment` as date_enrollment
    from staging_1.all_batch
    where `Date_of_Enrollment` is not null

    UNION ALL  -- Ensure this is present if combining with another SELECT

    select distinct `Date` as date_enrollment
    from staging_1.act_instruktur
    where `Date` is not null
)

select row_number() over (order by date_enrollment) as id, date_enrollment
from stg_date
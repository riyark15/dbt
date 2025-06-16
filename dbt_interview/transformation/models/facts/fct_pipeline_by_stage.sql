--This fact model summarizes monthly opportunity pipeline metrics by user and sales stage, 
--showing counts and total value of opportunities.


{{ config(
    materialized = 'table'
) }}

with base as (
    select
        opportunity_id,
        ownerid as user_id,
        lower(stagename) as stage_name,
        try_cast(amount as double) as amount,
        try_cast(createddate as date) as created_date
    from {{ ref('stg_salesforce__opportunity') }}
    where createddate is not null
),

with_date as (
    select
        b.*,
        d.date_id,
        d.month,
        d.year
    from base b
    left join {{ ref('dim_date') }} d
        on b.created_date = d.full_date
),

with_user as (
    select
        wd.*,
        u.username,
        u.country
    from with_date wd
    left join {{ ref('dim_user') }} u
        on wd.user_id = u.user_id
),

aggregated as (
    select
        user_id,
        username,
        country,
        stage_name,
        year,
        month,
        count(distinct opportunity_id) as opportunity_count,
        sum(coalesce(amount, 0)) as total_pipeline_value
    from with_user
    group by user_id, username, country, stage_name, year, month
)

select * from aggregated

--Yearly Opportunity Performance

with base as (
    select
        try_cast(createddate as date) as created_date,
        try_cast(closedate as date) as closed_date,
        stagename,
        amount
    from {{ ref('stg_salesforce__opportunity') }}
),

created as (
    select
        created_date,
        count(*) as opportunities_created,
        sum(coalesce(amount, 0)) as total_pipeline_value
    from base
    where created_date is not null
    group by created_date
),

won as (
    select
        closed_date,
        count(*) as opportunities_won,
        sum(coalesce(amount, 0)) as closed_won_value
    from base
    where lower(stagename) in ('closed won', 'won') and closed_date is not null
    group by closed_date
),

-- Join to dim_date
created_joined as (
    select
        d.year as year,
        c.opportunities_created,
        c.total_pipeline_value,
        0 as opportunities_won,
        0 as closed_won_value
    from {{ ref('dim_date') }} d
    left join created c on d.full_date = c.created_date
    where c.created_date is not null
),

won_joined as (
    select
        d.year as year,
        0 as opportunities_created,
        0 as total_pipeline_value,
        w.opportunities_won,
        w.closed_won_value
    from {{ ref('dim_date') }} d
    left join won w on d.full_date = w.closed_date
    where w.closed_date is not null
),

-- Combine and aggregate
final as (
    select
        year,
        sum(coalesce(opportunities_created, 0)) as opportunities_created,
        sum(coalesce(total_pipeline_value, 0)) as total_pipeline_value,
        sum(coalesce(opportunities_won, 0)) as opportunities_won,
        sum(coalesce(closed_won_value, 0)) as closed_won_value
    from (
        select * from created_joined
        union all
        select * from won_joined
    )
    group by year
)

select *
from final
order by year

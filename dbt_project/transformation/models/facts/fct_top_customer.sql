with base as (
    select
        accountid as customer_id,
        try_cast(amount as double) as deal_amount,
        try_cast(closedate as date) as close_date,
        stagename
    from {{ ref('stg_salesforce__opportunity') }}
    where lower(stagename) in ('closed won', 'won')
),

aggregated as (
    select
        customer_id,
        count(*) as total_closed_deals,
        sum(coalesce(deal_amount, 0)) as total_revenue,
        avg(coalesce(deal_amount, 0)) as avg_deal_size,
        min(close_date) as first_deal_date,
        max(close_date) as latest_deal_date
    from base
    where customer_id is not null
    group by customer_id
)

select *
from aggregated
order by total_revenue desc

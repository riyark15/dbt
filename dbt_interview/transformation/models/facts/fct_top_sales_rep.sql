--This fact table identifies the top-performing sales representative 
--based on opportunity conversion metrics.

with base as (
    select
        opportunity_id as opportunity_id,
        ownerid,
        isclosed,
        iswon,
        amount,
        case when isclosed and iswon then 1 else 0 end as is_converted
    from {{ ref('stg_salesforce__opportunity') }}
),

aggregated as (
    select
        ownerid,
        count(*) as total_opportunities,
        sum(is_converted) as converted_opportunities,
        sum(case when is_converted = 1 then amount else 0 end) as total_converted_amount
    from base
    group by ownerid
),

ranked as (
    select *,
           rank() over (order by converted_opportunities desc, total_converted_amount desc) as conversion_rank
    from aggregated
)

select * from ranked where conversion_rank = 1
--This fact table summarizes opportunity performance by campaign, showing counts 
--and revenue of total and closed-won opportunities.

with opportunities as (
    select
        campaignid as campaign_id,
        opportunity_id,
        stagename,
        amount
    from {{ ref('stg_salesforce__opportunity') }}
    where campaignid is not null
)

select
    campaign_id,
    count(distinct opportunity_id) as total_opportunities,
    count(distinct case when lower(stagename) in ('closed won', 'won') then opportunity_id end) as closed_won_opportunities,
    sum(coalesce(amount, 0)) as total_pipeline_value,
    sum(case when lower(stagename) in ('closed won', 'won') then coalesce(amount, 0) end) as closed_won_value
from opportunities
group by campaign_id

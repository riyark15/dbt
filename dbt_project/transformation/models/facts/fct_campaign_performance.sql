select
    campaign_id,
    campaign_name,
    type,
    status,
    expectedrevenue,
    budgetedcost,
    ifnull(actualcost,0) AS actualcost,
    numbersent,
    expectedrevenue - ifnull(actualcost,0) as expected_profit
from {{ ref('dim_campaign') }}
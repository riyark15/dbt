with source as (

    select * from {{ ref('stg_salesforce__campaign') }}

),


renamed as (


select
    campaign_id as campaign_id,
    name as campaign_name,
    status,
    type,
    startdate,
    enddate,
    expectedrevenue,
    budgetedcost,
    actualcost,
    numbersent
from {{ ref('stg_salesforce__campaign') }}

)
SELECT * FROM renamed
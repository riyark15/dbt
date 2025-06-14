with source as (

    select * from {{ ref('stg_salesforce__account') }}

),
renamed AS (

select
    account_id as account_id,
    name as account_name,
    industry,
    type,
    rating,
    billingcountry,
    ownerid,
    createddate
from {{ ref('stg_salesforce__account') }}

)
SELECT * FROM renamed
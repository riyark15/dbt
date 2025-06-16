{{ config(
    materialized='incremental',
    unique_key='opportunity_id'
) }}

with source as (
    select
        opportunity_id as opportunity_id,
        accountid as account_id,
        ownerid as user_id,
        stagename,
        amount,
        isclosed,
        iswon,
        closeDate,
        createdDate,
        lastmodifieddate
    from {{ ref('stg_salesforce__opportunity') }}
    
    {% if is_incremental() %}
      where lastmodifieddate > (select max(lastmodifieddate) from {{ this }})
    {% endif %}
)

select
    opportunity_id,
    account_id,
    user_id,
    stagename,
    amount,
    isclosed,
    iswon,
    closeDate,
    createdDate,
    lastmodifieddate
from source

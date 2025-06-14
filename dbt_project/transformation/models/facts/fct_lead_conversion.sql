with base as (
    select
        lead_id as lead_id,
        ownerid,
        status,
        isconverted,
        createddate,
        converteddate,
        datediff('day', CAST(createddate AS TIMESTAMP), CAST(converteddate AS TIMESTAMP)) AS days_to_convert
        --datediff('day', createddate, converteddate) as days_to_convert
    from {{ ref('stg_salesforce__lead') }}
    where isconverted = true
)

select
    ownerid,
    count(*) as converted_leads,
    avg(days_to_convert) as avg_days_to_convert
from base
group by ownerid



with source as (

    select * from {{ ref('stg_salesforce__lead') }}

),


renamed as (


select
    lead_id,
    firstname,
    lastname,
    email,
    company,
    industry,
    leadsource,
    status,
    ownerid,
    createddate,
    converteddate,
    isconverted
from {{ ref('stg_salesforce__lead') }}

)
SELECT * FROM renamed
with source as (

    select * from {{ ref('stg_salesforce__record_type') }}

),


renamed as (
select
    record_type_id as record_type_id,
    name as recordtype_name,
    sobjecttype,
    description,
    isactive
from {{ ref('stg_salesforce__record_type') }}
)
SELECT * FROM renamed
with source as (

    select * from {{ ref('stg_salesforce__product_2') }}

),


renamed as (
select
    product_id as product_id,
    name as product_name,
    productcode,
    description,
    family,
    isactive
from {{ ref('stg_salesforce__product_2') }}

)
SELECT * FROM renamed
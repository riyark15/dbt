with source as (

    select * from {{ ref('stg_salesforce__user_role') }}

),
renamed as (

select
    user_role_id as user_role_id,
    name as role_name,
    parentroleid
from {{ ref('stg_salesforce__user_role') }}
)
SELECT * FROM renamed
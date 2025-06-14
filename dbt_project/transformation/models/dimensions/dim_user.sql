with source as (

    select * from {{ ref('stg_salesforce__user') }}

),
renamed as (

select
    user_id as user_id,
    username,
    email,
    department,
    title,
    isactive,
    profileid,
    userroleid,
    createddate
from {{ ref('stg_salesforce__user') }}

)
SELECT * FROM renamed
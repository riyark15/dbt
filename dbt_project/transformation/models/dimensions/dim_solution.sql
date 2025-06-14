with source as (

    select * from {{ ref('stg_salesforce__solution') }}

),
renamed as (
select
    solution_id as solution_id,
    solutionname,
    ispublished,
    status,
    createddate
from {{ ref('stg_salesforce__solution') }}
)
SELECT * FROM renamed
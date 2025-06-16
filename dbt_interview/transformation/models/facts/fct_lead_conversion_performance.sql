with base as (
    select
        lead_id,
        ownerid,
        try_cast(createddate as date) as created_date,
        try_cast(converteddate as date) as converted_date,
        isconverted
    from {{ ref('dim_lead') }}
),

created as (
    select
        created_date as date,
        count(*) as leads_created
    from base
    group by created_date
),

converted as (
    select
        converted_date as date,
        count(*) as leads_converted
    from base
    where isconverted = true and converted_date is not null
    group by converted_date
),

final as (
    select
        d.date_id,
        d.full_date,
        coalesce(c.leads_created, 0) as leads_created,
        coalesce(v.leads_converted, 0) as leads_converted
    from {{ ref('dim_date') }} d
    left join created c on d.full_date = c.date
    left join converted v on d.full_date = v.date
)

select * from final

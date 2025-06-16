with date_spine as (
    select
        date '2010-01-01' + (n || ' days')::interval as full_date
    from range(0, 8000) as t(n)
),

final as (
    select
        full_date as date_id,
        full_date,
        extract(year from full_date) as year,
        extract(month from full_date) as month,
        extract(day from full_date) as day,
        strftime(full_date, '%Y-%m') as year_month,
        extract(quarter from full_date) as quarter,
        strftime(full_date, '%Y') || '-Q' || extract(quarter from full_date) as year_quarter,
        extract(dow from full_date) + 1 as day_of_week,  -- Sunday=1
        strftime(full_date, '%A') as weekday_name,
        case when extract(dow from full_date) in (5, 6) then true else false end as is_weekend,
        full_date = last_day(full_date) as is_month_end,
        extract(day from full_date) = 1 as is_month_start,
        strftime(full_date, '%W') as week_of_year
    from date_spine
)

select * from final

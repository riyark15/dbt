SELECT *
FROM {{ ref('fct_lead_conversion') }}
WHERE avg_days_to_convert < 0
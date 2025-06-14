SELECT *
FROM {{ ref('fct_opportunity') }}
WHERE LOWER(stage_name) IN ('closed won', 'won')
  AND (amount IS NULL OR amount = 0)
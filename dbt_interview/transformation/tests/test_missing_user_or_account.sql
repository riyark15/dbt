SELECT *
FROM {{ ref('fct_opportunity') }}
WHERE user_id IS NULL
   OR account_id IS NULL
SELECT *
FROM {{ ref('fct_opportunity') }}
WHERE amount < 0
SELECT fsr.*
FROM {{ ref('fct_top_sales_rep') }} fsr
LEFT JOIN {{ ref('dim_user') }} du
  ON fsr.ownerid = du.user_id
WHERE du.user_id IS NULL
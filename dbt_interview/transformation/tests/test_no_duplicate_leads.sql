SELECT lead_id, COUNT(*)
FROM {{ ref('dim_lead') }}
GROUP BY lead_id
HAVING COUNT(*) > 1
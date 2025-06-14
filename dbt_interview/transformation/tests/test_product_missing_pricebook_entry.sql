SELECT *
FROM {{ ref('fct_pricebook_entry') }}
WHERE product2id IS NULL
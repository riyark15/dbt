with pricebook_entry as (
    select
        pricebook_entry_id,
        product2id,
        pricebook2id,
        unitprice,
        isactive
    from dbt.staging.stg_salesforce__pricebook_entry
),

product as (
    select
        product_id,
        product_name,
        productcode
    from dbt.salesforce_marts.dim_product
),

joined as (
    select
        pbe.pricebook_entry_id,
        pbe.product2id,
        pr.product_name,
        pr.productcode,
        pbe.pricebook2id,
        pbe.unitprice,
        pbe.isactive
    from pricebook_entry pbe
    left join product pr on pbe.product2id = pr.product_id
)

select *
from joined

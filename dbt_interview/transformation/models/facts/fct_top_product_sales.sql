--It helps in identifying top-performing products based on 
--sales volume and revenue contribution.

with products_sold as (
    select
        pbe.product2id as product_id,
        o.opportunity_id,
        o.stagename,
        o.amount
    from {{ ref('stg_salesforce__pricebook_entry') }} pbe
    left join {{ ref('stg_salesforce__opportunity') }} o
        on pbe.pricebook_entry_id = o.pricebook2id 
    where o.stagename is not null
)

select
    product_id,
    count(distinct opportunity_id) as total_sales_count,
    count(distinct case when lower(stagename) in ('closed won', 'won') then opportunity_id end) as closed_won_sales_count,
    sum(coalesce(amount, 0)) as total_revenue,
    sum(case when lower(stagename) in ('closed won', 'won') then coalesce(amount, 0) end) as closed_won_revenue
from products_sold
group by product_id

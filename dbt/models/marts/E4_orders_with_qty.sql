{{ config(materialized='table') }}

with order_qty as (
    select
        order_id,
        sum(quantity) as qty_product
    from {{ ref('stg_sales_recrutement') }}
    group by order_id
),

orders_filtered as (
    select
        *
    from {{ ref('stg_orders_recrutement') }}
    where extract(year from order_date) in (2022, 2023)
)

select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.net_sales,
    coalesce(oq.qty_product, 0) as qty_product
from orders_filtered o
left join order_qty oq
    on o.order_id = oq.order_id
order by o.order_date
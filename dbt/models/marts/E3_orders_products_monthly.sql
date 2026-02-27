{{ config(materialized='table') }}

with order_products as (
    select
        order_id,
        sum(quantity) as total_products
    from {{ ref('stg_sales_recrutement') }}
    group by 1
),

orders_with_date as (
    select
        order_id,
        order_date
    from {{ ref('stg_orders_recrutement') }}
    where extract(year from order_date) = 2023
)

select
    format_date('%Y-%m', o.order_date) as order_month,
    avg(op.total_products) as avg_products_per_order
from orders_with_date o
join order_products op
    on o.order_id = op.order_id
group by 1
order by 1
{{ config(materialized='table') }}

select 
    format_date('%Y-%m', order_date) as order_month,
    count(distinct order_id) as number_of_orders
from {{ ref("stg_orders_recrutement") }}
where extract(year from order_date) = 2023
group by 1
order by 1
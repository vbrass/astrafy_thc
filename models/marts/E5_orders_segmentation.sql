{{ config(materialized='table') }}

-- Step 1: Get all orders in 2023
with orders_2023 as (
    select
        order_id,
        customer_id,
        order_date,
    from {{ ref('stg_orders_recrutement') }}
    where extract(year from order_date) = 2023
),

-- Step 2: Count past orders per customer in the 12 months prior to each 2023 order
customer_past_orders as (
    select
        o2023.order_id,
        o2023.customer_id,
        o2023.order_date,
        count(past.order_id) as past_orders_count
    from orders_2023 o2023
    left join {{ ref('stg_orders_recrutement') }} past
        on past.customer_id = o2023.customer_id
       -- Only consider past orders in the 12 months before current order
       and past.order_date >= date_sub(o2023.order_date, interval 12 month)
       and past.order_date < o2023.order_date
    group by o2023.order_id, o2023.customer_id, o2023.order_date
)

-- Step 3: Assign segment based on past orders count
select
    order_id,
    customer_id,
    order_date,
    case
        when past_orders_count = 0 then 'New'
        when past_orders_count between 1 and 3 then 'Returning'
        when past_orders_count >= 4 then 'VIP'
    end as order_segmentation
from customer_past_orders
order by order_date
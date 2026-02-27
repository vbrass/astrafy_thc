{{ config(materialized='table') }}

-- Similar logic than question 5 but with a more concise query and including the net_sales column

-- Step 1: reuse the segmentation logic from question 5
with segmented_orders as (
    select
        o2023.order_id,
        o2023.customer_id,
        o2023.order_date,
        case
            when count(past.order_id) = 0 then 'New'
            when count(past.order_id) between 1 and 3 then 'Returning'
            when count(past.order_id) >= 4 then 'VIP'
        end as order_segmentation
    from {{ ref('stg_orders_recrutement') }} o2023
    left join {{ ref('stg_orders_recrutement') }} past
        on past.customer_id = o2023.customer_id
       and past.order_date >= date_sub(o2023.order_date, interval 12 month)
       and past.order_date < o2023.order_date
    where extract(year from o2023.order_date) = 2023
    group by o2023.order_id, o2023.customer_id, o2023.order_date
)

-- Step 2: enrich 2023 orders with their segmentation
select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.net_sales,
    s.order_segmentation
from {{ ref('stg_orders_recrutement') }} o
join segmented_orders s
    on o.order_id = s.order_id
order by o.order_date
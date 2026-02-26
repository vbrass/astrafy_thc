{{ config(materialized='table') }}

select
    count(*) as orders_2023
from {{ ref("stg_orders_recrutement") }}
where extract(year from order_date) = 2023
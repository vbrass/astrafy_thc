{{ config(materialized='view') }}

select 
    orders_id as order_id, 
    customers_id as customer_id,
    cast(date_date as date) as order_date,
    cast(net_sales as numeric) as net_sales
from {{ source('astrafy_thc', 'orders_recrutement')}}
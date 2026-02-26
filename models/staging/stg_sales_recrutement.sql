{{ config(materialized='view') }}

select
    order_id,
    products_id as product_id,
    cast(qty as int64) as quantity,
    cast(net_sales as numeric) as net_sales
from {{ source('astrafy_thc', 'sales_recrutement') }}
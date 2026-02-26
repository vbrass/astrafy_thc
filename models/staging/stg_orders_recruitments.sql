select
    *
from {{ source('astrafy_thc', 'orders_recrutments') }}
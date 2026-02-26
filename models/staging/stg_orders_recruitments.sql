-- Creation of a staging environment for scalability
select * from {{ source("astrafy_thc", "orders_rectrutments")}};
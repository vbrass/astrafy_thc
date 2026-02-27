view: orders{
    sql_table_name: dbt_vbrass.E6_orders_segmentation;;
}

dimension: order_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_id ;;
}

dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
}

dimension: order_date {
    type: date
    sql: ${TABLE}.order_date
}

dimension_group: order_month {
    type: time
    timesframes: [month, year]
    sql: ${TABLE}.order_date ;;
}

dimension: order_segmentation {
    type: string
    sql: ${TABLE}.order_segmentation ;;
}

measure: orders_count{
    type: count
    description: "Number of orders"
}

measure: total_revenue{
    type: sum
    sql: ${TABLE}.net_sales ;;
    value_format_name: "chf"
}

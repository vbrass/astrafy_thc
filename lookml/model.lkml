connection: "bigquery_connection"

include: "/views/*.view.lkml"
include: "/explores/*.explore.lkml"

explore: orders{}
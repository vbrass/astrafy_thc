# astrafy_thc
Repository for the Astrafy's Take Home Challenge. <br>
A data modeling and semantic layer exercise.

## Overview

This repository contains the implementation of a full analytics workflow composed of:
- a **data transformation layer** built with **dbt** on **BigQuery**
- a **semantic layer** implemented in **LookML**, designed to be consumed in **Looker**
- a **dashboard** created on **LookerStudio**, accessible [here](https://lookerstudio.google.com/reporting/4fd7d69f-78ed-420e-8f74-4abcd7070941).

The objective of the project is to answer a series of analytical questions on orders and customers, and to expose a clean, business-friendly semantic model enabling dashboard creation.

---

## Architecture

The project follows a standard modern analytics stack:

- BigQuery (raw data)
- dbt (staging and marts)
- LookML (semantic layer)
- LookerStudio (dashboard and analysis)

---

## Repository Structure

```bash
├── dbt/
│ ├── models/
│ │ ├── staging/
│ │ │ ├── stg_orders_recrutement.sql
│ │ │ └── stg_sales_recrutement.sql
│ │ ├── marts/
│ │ │ ├── E1_orders_2023_count.sql
│ │ │ ├── E2_orders_2023_monthly.sql
│ │ │ ├── E3_orders_products_monthly.sql
│ │ │ ├── E4_orders_with_quantity.sql
│ │ │ ├── E5_orders_segmentation.sql
│ │ │ └── E6_orders_segmentation.sql
│ │ └── schema.yml
│ └── dbt_project.yml
│
├── lookml/
│ ├── model.lkml
│ ├── orders.view.lkml
│ └── orders.explore.lkml
│
└── README.md
```

---

## dbt Layer

### Purpose

The dbt layer is responsible for:
- cleaning raw order data
- enforcing one-row-per-order grain
- computing derived metrics (e.g. `qty_product`)
- implementing order segmentation logic
- exposing analysis-ready tables for the semantic layer

### Key Concepts

- **Staging models** (`stg_*`) normalize raw source tables
- **Mart models** answer specific business questions and serve LookML
- Time-based logic and customer segmentation are implemented in dbt, not LookML

### Implemented Exercises

- **Exercise 1**: Total number of orders in 2023  
- **Exercise 2**: Number of orders per month in 2023  
- **Exercise 3**: Average number of products per order per month (2023)  
- **Exercise 4**: Orders table (2022–2023) with product quantity per order  
- **Exercise 5 & 6**: Order segmentation (New / Returning / VIP) for 2023 orders  

All dbt models are documented using `schema.yml`.

---

## LookML Semantic Layer

### Purpose

The LookML layer provides:
- business-friendly dimensions and measures
- reusable metrics for dashboards
- consistent customer segmentation logic
- a clean analytical entry point for Looker users

### Design Principles

- LookML **does not transform data**
- Aggregations and segmentation are handled upstream in dbt
- Time analysis is handled via `dimension_group`
- Measures are defined once and reused across analyses

### Main Components

- **`orders.view.lkml`**  
  Defines dimensions (dates, segmentation) and measures (order count, revenue)

- **`orders.explore.lkml`**  
  Defines how users can analyze orders in Looker

- **`model.lkml`**  
  Declares the LookML model and database connection

> LookML files are provided as semantic definitions intended to be imported into a Looker instance connected to BigQuery.

---

## Notes on Execution

- Looker access is **not required** to review this repository
- LookML files are plain text and designed to be versioned via Git
- The semantic layer is intentionally simple and maintainable, aligned with best practices

---

## Author

Victor Brass

{{ config (
    materialized="table"
)}}


with dim_customers as (

    select
        stg_customers.customer_id,
        stg_customers.first_name,
        stg_customers.last_name,
        stg_customer_orders.first_order_date,
        stg_customer_orders.most_recent_order_date,
        coalesce(stg_customer_orders.number_of_orders, 0) as number_of_orders

    from {{ ref("stg_customers") }}

    left join {{ ref("stg_customer_orders") }} using (customer_id)

)

select * from dim_customers
with dim_customers as (

    select
        stg_customers.customer_id,
        stg_customers.first_name,
        stg_customers.last_name,
        stg_customer_orders.first_order_date,
        stg_customer_orders.most_recent_order_date,
        customerlifetimevalue,
        number_of_orders
    from {{ ref("stg_customers") }}
    left join {{ ref("stg_customer_orders") }} using (customer_id)
    left join {{ ref("customerlifetimevalue") }} using (customer_id)
    left join {{ ref("numberofcustomerorders") }} using (customer_id)

)

select * from dim_customers
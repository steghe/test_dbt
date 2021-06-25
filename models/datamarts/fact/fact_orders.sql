with fact_orders as (

    select

        stg_orders.customer_id,
        stg_orders.order_id,
        customerlifetimevalue

    from {{ ref("stg_orders") }} 
    left join {{ ref("customerlifetimevalue") }} using (customer_id)

)

select * from fact_orders
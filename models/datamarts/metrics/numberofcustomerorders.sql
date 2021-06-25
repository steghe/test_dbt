with customers as (select * from {{ ref("stg_customers") }}),
customer_orders as (select * from {{ ref("stg_customer_orders") }}),
final as (

    select
        customers.customer_id,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders
    from customers
    left join customer_orders using (customer_id)
)

select * from final
with payments as (select * from {{ ref("stg_payments") }}),
orders as (select * from {{ ref("stg_orders") }}),

final as (
    select 
        customer_id,
        sum(case when status = 'success' then amount/100 end) as customerlifetimevalue
    from payments
    left join orders using (order_id)
    group by customer_id
)

select * from final
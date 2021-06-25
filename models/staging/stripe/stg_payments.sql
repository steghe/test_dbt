with final as (
    select
    ID as payment_id,
    ORDERID as order_id,
    PAYMENTMETHOD,
    STATUS,
    AMOUNT,
    CREATED
    from {{ source('stripe', 'payment') }} 
)

select * from final
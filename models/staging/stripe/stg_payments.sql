with final as (
    select
    ID as payment_id,
    ORDERID as order_id,
    PAYMENTMETHOD,
    STATUS,
    AMOUNT,
    CREATED
    from test_dbt.stripe.payment
)

select * from final
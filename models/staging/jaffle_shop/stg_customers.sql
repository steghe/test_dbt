with final as (

    select
        id as customer_id,
        first_name,
        last_name

    from test_dbt.jaffle_shop.customers

)

select * from final
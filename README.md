Welcome to your new dbt project!

### snowflake user creation

###per ogni utente
drop user sg_dbt;
create user sg_dbt;
alter user sg_dbt set password = 'sg_dbt';
alter user sg_dbt 
set rsa_public_key = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA5dyyWXofqh/P22dZYb8IBYJageU41hC/+KYolEDxPbzIaNEQbKBrmUnqA6cGM/sLOa6Cch33FytxFOMF05mbSSNtwHfGxDjlt1M5vWOUHHlIuMIEaUWXTAjT1TIGD2ni3NYZ74npApf8ZIwGVOWcFXhH0Q4/+bOwR1BDF5Db5Dw5zBhYhRWjWYVnow92T2NVSP/khzUU16/JMXmjfLzwe73yGp6fhkxVoHOBpC/9CsfjXLJSweeuzXUMB6dFSC/G8Z0+ZGouYSSM7+JBp7owiyCraOlm6fvYAOCV1V0yED30kMUgkJ86w2ruumXXDoj2tw8jmXsf5ZL+iBTjz0Ea6wIDAQAB';
grant role dbt_users to user sg_dbt;

###una tantum on snowflake
drop role dbt_users;
create role dbt_users;
drop database dev_on_dbt;
create database dev_on_dbt;
grant all on database dev_on_dbt to role dbt_users;
grant usage on warehouse dbt_engine to role dbt_users;
grant all on database dev_on_dbt to dbt_users;
grant all on schema jaffle_shop to dbt_users;
grant all on schema stripe to dbt_users;
grant select on   dev_on_dbt.jaffle_shop.customers to dbt_users;
grant select on   dev_on_dbt.jaffle_shop.orders to dbt_users;
grant select on   dev_on_dbt.stripe.payment to dbt_users;


create schema if not exists dev_on_dbt.jaffle_shop;

-- create this one directly in the schema
drop table if exists dev_on_dbt.jaffle_shop.customers;
create table dev_on_dbt.jaffle_shop.customers
(
    id integer,
    first_name varchar,
    last_name varchar
);

copy into dev_on_dbt.jaffle_shop.customers (id, first_name, last_name)
    from 's3://dbt-tutorial-public/jaffle_shop_customers.csv'
        file_format = (
            type = 'CSV'
            field_delimiter = ','
            skip_header = 1
        )
;

drop table if exists dev_on_dbt.jaffle_shop.orders;
create table dev_on_dbt.jaffle_shop.orders
(
  id integer,
  user_id integer,
  order_date date,
  status varchar,
  _etl_loaded_at timestamp default current_timestamp
);

copy into dev_on_dbt.jaffle_shop.orders (id, user_id, order_date, status)
    from 's3://dbt-tutorial-public/jaffle_shop_orders.csv'
        file_format = (
            type = 'CSV'
            field_delimiter = ','
            skip_header = 1
        )
;

create schema if not exists dev_on_dbt.stripe;

drop table if exists dev_on_dbt.stripe.payment;
create table dev_on_dbt.stripe.payment (
  id integer,
  orderid integer,
  paymentmethod varchar,
  status varchar,
  amount integer,
  created date,
  _batched_at timestamp default current_timestamp
);

copy into dev_on_dbt.stripe.payment (id, orderid, paymentmethod, status, amount, created)
from 's3://dbt-tutorial-public/stripe_payments.csv'
    file_format = (
        type = 'CSV'
        field_delimiter = ','
        skip_header = 1
    )
;

grant all on database dev_on_dbt to dbt_users;


### Using the starter project

Try running the following commands:
- dbt run
- dbt test



### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

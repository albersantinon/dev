
  create or replace   view analytics.albertosantinon7_staging.stg_transactional_src__orders_q1
  
   as (
    with source as (

    select * from acme_ecommerce.transactional.order_2023_q1

)

select * from source
  );


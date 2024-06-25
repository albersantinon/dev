
  create or replace   view analytics.albertosantinon7_staging.stg_transactional_src__orders_q3
  
   as (
    with source as (

    select * from acme_ecommerce.transactional.order_2023_q3

)

select * from source
  );


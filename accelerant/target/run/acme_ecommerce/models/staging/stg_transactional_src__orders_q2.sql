
  create or replace   view analytics.albertosantinon7_staging.stg_transactional_src__orders_q2
  
   as (
    with source as (

    select * from acme_ecommerce.transactional.order_2023_q2

)

select * from source
  );



  create or replace   view analytics.albertosantinon7_staging.stg_reference_data_src__products
  
   as (
    with source as (

    select * from acme_ecommerce.reference_data.product

)

select * from source
  );


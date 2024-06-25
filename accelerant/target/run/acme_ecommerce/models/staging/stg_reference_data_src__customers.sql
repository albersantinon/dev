
  create or replace   view analytics.albertosantinon7_staging.stg_reference_data_src__customers
  
   as (
    with source as (

    select * from acme_ecommerce.reference_data.customer

)

select * from source
  );


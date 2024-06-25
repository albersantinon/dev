
  create or replace   view analytics.albertosantinon7_staging.stg_reference_data_src__countries
  
   as (
    with source as (

    select * from acme_ecommerce.reference_data.country

)

select * from source
  );


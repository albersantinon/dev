
  create or replace   view analytics.albertosantinon7_staging.stg_product_inventory_src__product_inventories
  
   as (
    with source as (

    select * from acme_ecommerce.product_inventory.inventory

)

select * from source
  );


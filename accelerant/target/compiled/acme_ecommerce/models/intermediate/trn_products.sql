with products as (

    select
	"prodid" as "product_id",
	"prodname" as "product_name",
	"prodcat" as "product_category"
    from analytics.albertosantinon7_staging.stg_reference_data_src__products

)

select * from products
with inventory as (

    select
 	"prodid" as "product_id",
	"stock_arrival_date",
	ifnull("stock_depleted_date", to_date('9999-12-31','YYYY-MM-DD')) as "stock_depleted_date",
	"purchase_price"
    from analytics.albertosantinon7_staging.stg_product_inventory_src__product_inventories

)

select * from inventory
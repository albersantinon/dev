with transaction
as

(
select
a."transaction_id"
, a."transaction_timestamp"
, a."shipped_timestamp"
, a."product_id"
, a."customer_id"
, b."stock_arrival_date"
, b."stock_depleted_date"
, b."purchase_price"
, a."quantity"
, a."unit_price"
, (a."unit_price" - b."purchase_price")*a."quantity" as "value"
from analytics.albertosantinon7_intermediate.trn_transactional_orders a 
join analytics.albertosantinon7_intermediate.trn_inventory b
on a."product_id" = b."product_id"
where to_date("transaction_timestamp") > "stock_arrival_date"
and to_date("shipped_timestamp") < "stock_depleted_date"
order by 1
),

customers as (


    select
    "customer_code"
    , "first_name" || "last_name" as "cust_name"
    , "email_address"
    , "country"
    , "region"
    from analytics.albertosantinon7_intermediate.trn_customer as a
    join analytics.albertosantinon7_intermediate.trn_country as b
    on (a."country_code" = b."country_code")
    where "active_flag" = TRUE

),

products as
(

    select *
    from analytics.albertosantinon7_intermediate.trn_products

)

, intermediate as (
select
t.*
, p."product_name"
, p."product_category"
, c."cust_name"
, c."email_address"
, c."country"
, c."region"
, date_part('month', t."transaction_timestamp") as "transaction_month"
, date_part('quarter', t."transaction_timestamp") as "transaction_quarter"
, date_part('year', t."transaction_timestamp") as "transaction_year"
, date_part('month', t."shipped_timestamp") as "shipping_month"
, date_part('quarter', t."shipped_timestamp") as "shipping_quarter"
, date_part('year', t."shipped_timestamp") as "shipping_year"
, case when "value" between 0 and 1000 then 'band 1'
       when "value" between 1001 and 5000 then 'band 2'
       when "value" > 5000 then 'band 3'
  end as "sales_band"
from transaction t 
join products p on t."product_id" = p."product_id"
join customers c on t."customer_id" = c."customer_code")

select
"transaction_id"
,"transaction_timestamp"
,"transaction_quarter"
,"transaction_month"
,"transaction_year"
,"shipping_quarter"
,"shipping_month"
,"shipping_year"
,"product_name"
,"product_category"
,"cust_name"
,"email_address"
,"country"
,"region"
,"sales_band"
from intermediate
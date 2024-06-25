with orders_q1 AS
(

    SELECT
    "transaction_id",
	TO_TIMESTAMP_NTZ("transaction_timestamp",'DD/MM/YYYY HH24:MI') as "transaction_timestamp",
	TO_TIMESTAMP_NTZ("shipped_timestamp",'DD/MM/YYYY HH24:MI') as "shipped_timestamp",
	"product_id",
	"customer_id",
	"quantity",
	"unit_price"
    FROM {{ ref('stg_transactional_src__orders_q1') }}

),

orders_q2 AS
(

    SELECT
    "transaction_id",
	TO_TIMESTAMP_NTZ("transaction_timestamp",'DD/MM/YYYY HH24:MI') as "transaction_timestamp",
	TO_TIMESTAMP_NTZ("shipped_timestamp",'DD/MM/YYYY HH24:MI') as "shipped_timestamp",
	"product_id",
	"customer_id",
	"quantity",
	"unit_price"
    FROM {{ ref('stg_transactional_src__orders_q2') }}

),

orders_q3 AS
(

    SELECT
    "transaction_id",
	TO_TIMESTAMP_NTZ("transaction_timestamp",'DD/MM/YYYY HH24:MI') as "transaction_timestamp",
	TO_TIMESTAMP_NTZ("shipping_timestamp",'DD/MM/YYYY HH24:MI') as "shipped_timestamp",
	"product_id",
	"customer_id",
	"quantity",
	"unit_price"
    FROM {{ ref('stg_transactional_src__orders_q3') }}

),

orders_q4 AS
(

    SELECT
    "transaction_id",
	TO_TIMESTAMP_NTZ("transaction_timestamp",'DD/MM/YYYY HH24:MI') as "transaction_timestamp",
	TO_TIMESTAMP_NTZ("shipping_timestamp",'DD/MM/YYYY HH24:MI') as "shipped_timestamp",
	"product_id",
	"customer_id",
	"quantity",
	"unit_price"
    FROM {{ ref('stg_transactional_src__orders_q4') }}

)

select * from orders_q1
union
select * from orders_q2
union
select * from orders_q3
union
select * from orders_q4
order by 1
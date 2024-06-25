
  create or replace   view analytics.albertosantinon7_intermediate.trn_customer
  
   as (
    with customer as (

    select
	"customer code" as "customer_code",
	"first name" as "first_name",
	"last name" as "last_name",
	"email address" as "email_address",
	"iso country code" as "country_code"
    from analytics.albertosantinon7_staging.stg_reference_data_src__customers

)

select * from customer
  );



  create or replace   view analytics.albertosantinon7_intermediate.trn_country
  
   as (
    with country as (

    select
 	"alpha_3_country_code" as "country_code",
	"country",
	"region",
	"active_flag"
    from analytics.albertosantinon7_staging.stg_reference_data_src__countries

)

select * from country
  );


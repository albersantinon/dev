with country as (

    select
 	"alpha_3_country_code" as "country_code",
	"country",
	"region",
	"active_flag"
    from {{ ref('stg_reference_data_src__countries') }}

)

select * from country
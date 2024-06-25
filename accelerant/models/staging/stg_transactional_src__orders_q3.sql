with source as (

    select * from {{ source('transactional_orders', 'order_2023_q3') }}

)

select * from source

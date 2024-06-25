with source as (

    select * from {{ source('transactional_orders', 'order_2023_q4') }}

)

select * from source

with source as (

    select * from {{ source('transactional_orders', 'order_2023_q2') }}

)

select * from source

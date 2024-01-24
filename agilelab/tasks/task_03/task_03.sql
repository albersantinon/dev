-- query that retrieves the last value of the day for each brand
-- in the first CTE we're calculating the day of the order derived from the created_at field
-- in the second CTE we use the window function last_value to retrieve the last value partitioning by brand and day
-- the last select compares the id with the last value and retrieves only the rows that are the same
-- in this way we can retrieve the requested rows
-- assuming the underlying database is Snowflake I used date_part and last_value

with ordini_giorno as
(

    select *, date_part('day', created_at::date) as created_at_day
    from orders

)
, ultimo_valore as

(

select *, last_value(id) over (partition by brand_id, created_at_day order by created_at) as 'last value'
from ordini_giorno
order by created_at, brand_id asc

)

select id, transaction_value, created_at
from ultimo_valore
where id = last_value
order by 3
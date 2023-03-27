with ordini_giorno as
(

    select *, date_part('day', created_at) as created_at_day
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
select
    s.date_date,
    s.orders_id,
    s.pdt_id as products_id,
    s.revenue,
    s.quantity,
    p.purchse_price,
    round(s.quantity * p.purchse_price, 2) as purchase_cost,
    round(s.revenue - s.quantity * p.purchse_price, 2) as margin
from {{ ref('stg_raw__sales') }} as s
left join {{ ref('stg_raw__product') }} as p
    on s.pdt_id = p.products_id
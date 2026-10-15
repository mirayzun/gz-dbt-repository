WITH sales AS (
    SELECT * 
    FROM {{ ref('stg_raw__sales') }}
),

product AS (
    SELECT * 
    FROM {{ ref('stg_raw__product') }}
)

SELECT
    sales.date_date,
    sales.orders_id,
    sales.pdt_id AS products_id, 
    sales.revenue,
    sales.quantity,
    product.purchse_price AS purchase_price,
    
    -- satın_alma_maliyeti = miktar * satın_alma_fiyatı
    sales.quantity * product.purchse_price AS purchase_cost,
    
    -- marj = gelir - satın_alma_maliyeti
    sales.revenue - (sales.quantity * product.purchse_price) AS margin

FROM sales
LEFT JOIN product
    ON sales.pdt_id = product.products_id 
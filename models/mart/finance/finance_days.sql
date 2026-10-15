

WITH orders_operational AS (
    SELECT *
    FROM {{ ref('int_orders_operational') }}
)

SELECT
    date_date,
    
    -- 1. Toplam İşlem Sayısı
    COUNT(DISTINCT orders_id) AS nb_transactions,
    
    -- 2. Toplam Gelir
    ROUND(SUM(revenue), 2) AS revenue,
    
    -- 3. Ortalama Sepet Tutarı (AOV)
    ROUND(
        SUM(revenue) / NULLIF(COUNT(DISTINCT orders_id), 0), 
        2
    ) AS average_basket,
    
    -- 4. Toplam Operasyonel Marj
    ROUND(SUM(operational_margin), 2) AS operational_margin,
    
    -- 5. Toplam Satın Alma Maliyeti
    ROUND(SUM(purchase_cost), 2) AS purchase_cost,
    
    -- 6. Toplam Nakliye Ücreti (Müşteriden alınan)
    ROUND(SUM(shipping_fee), 2) AS shipping_fee,
    
    -- 7. Toplam Lojistik Maliyeti
    ROUND(SUM(logcost), 2) AS logcost,
    
    -- 8. Toplam Kargo/Nakliye Maliyeti
    ROUND(SUM(ship_cost), 2) AS ship_cost,
    
    -- 9. Satılan Toplam Ürün Miktarı
    SUM(quantity) AS quantity

FROM orders_operational
GROUP BY 
    date_date
ORDER BY 
    date_date DESC
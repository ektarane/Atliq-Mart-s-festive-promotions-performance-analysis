with promo_price as 
(
select 
*,
case 
   when promo_type = '25% OFF' then base_price * 0.75
   when promo_type = '33% OFF' then base_price * 0.67
   when promo_type = '50% OFF' then base_price * 0.50
   when promo_type = 'BOGOF' then base_price/2
   else base_price - 500
end   
   as promo_price 
FROM dim_products p
JOIN fact_events e
USING (product_code)
)

SELECT
     DISTINCT product_name AS Product,
     category AS Category,
     round(
           (
	        (
               sum(promo_price*quantity_sold_after_promo) - 
		       sum(base_price*quantity_sold_before_promo)
		    )  /
		         sum(base_price*quantity_sold_before_promo)
		   )  *100
               ,2
	       ) 
            as IR_pct
FROM promo_price
GROUP BY Product, category
ORDER BY IR_pct DESC LIMIT 5




#Provide a list of products with a base price greater than 500 and that are featured
#in promo type of 'BOGOF' (Buy One Get One Free). #

SELECT 
DISTINCT p.product_name as Product,
	     e.base_price as Base_Price,
	     e.promo_type as Promo_Type
FROM dim_products p
JOIN fact_events e
USING (product_code)
WHERE e.base_price > 500 and
	  e.promo_type = 'BOGOF'
ORDER BY base_price asc
  

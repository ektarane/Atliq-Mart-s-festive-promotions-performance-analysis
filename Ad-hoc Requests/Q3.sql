#Generate a report that displays each campaign along with the total revenue
#generated before and after the campaign? The report includes three key fields:
#campaign_name, total_reven u ),
#total_revenue(after_promotion ). This report should help in evaluating the financial
#impact of our promotional campaigns. (Display the values in millions)


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
from dim_campaigns c
        JOIN
    fact_events e USING (campaign_id)
)    
select 
    campaign_name AS Campaign_Name,
    CONCAT(ROUND(SUM(base_price * quantity_sold_before_promo) / 1000000,2),' M') AS Total_Revenue_before_Campaign,
    CONCAT(ROUND(SUM(promo_price * quantity_sold_after_promo) / 1000000,2),' M') AS Total_Revenue_after_Campaign
 from promo_price
GROUP BY Campaign_name 
ORDER BY Campaign_name;

    
 
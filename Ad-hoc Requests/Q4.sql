#Produce a report that calculates the Incremental Sold Quantity (ISU%) for each
##category during the Diwali campaign. Additionally, provide rankings for the
#categories based on their ISU%. The report will include three key fields:
#category, isu%, and rank order. This information will assist in assessing the
#category-wise success and impact of the Diwali campaign on incremental sales.
#Note: ISU% (Incremental Sold Quantity Percentage) is calcu lated as the
#percentage increase/decrease in quantity sold (after promo) compared to
#quantity sold (before promo)
with isu_pct as 
(select
p.category as Category,
round(((sum(e.quantity_sold_after_promo) - sum(e.quantity_sold_before_promo))/ 
                                   sum(e.quantity_sold_before_promo))*100,2) as ISU_pct
from dim_products p
join fact_events e
using (product_code)
where campaign_id = 'CAMP_DIW_01'
group by p.category
)
select 
*,
dense_rank()OVER(ORDER BY isu_pct DESC) AS RANK_ORDER 
from isu_pct 
;


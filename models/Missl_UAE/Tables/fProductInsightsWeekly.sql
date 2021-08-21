
(select * ,'MissL' Halo_Country,
       concat(format_date('%d %b %y',Startdate),' - ',format_date('%d %b %y',Startdate + 6)) DateRange
from
(select
row_number() over(partition by product_id,product_title order by year desc, week desc) week_year_no,
product_id,
product_sku,
product_title,
week,
year,
image,
inventory,
mrp,
selling_price,
dateweek,
Startdate,
Enddate,
impressions,
upv,
sales,
Units,
Clicks,
Revenue,
Addstocart,
lag(impressions,1) over (partition by product_id order by year,week) lwImpressions,
lag(impressions,2) over (partition by product_id order by year,week) lw2Impressions,
lag(impressions,3) over (partition by product_id order by year,week) lw3Impressions,
lag(Clicks,1) over (partition by product_id order by year,week)     lwUPV,
lag(Clicks,2) over (partition by product_id order by year,week) lw2Clicks,
lag(Clicks,3) over (partition by product_id order by year,week) lw3Clicks,
lag(UPV,1) over (partition by product_id order by year,week)     lwClicks,
lag(UPV,2) over (partition by product_id order by year,week) lw2UPV,
lag(UPV,3) over (partition by product_id order by year,week) lw3UPV,
lag(sales,1) over (partition by product_id order by year,week) lwSales,
lag(sales,2) over (partition by product_id order by year,week) lw2Sales,
lag(sales,3) over (partition by product_id order by year,week) lw3Sales,
lag(Units,1) over (partition by product_id order by year,week) lwUnits,
lag(Units,2) over (partition by product_id order by year,week) lw2Units,
lag(Units,3) over (partition by product_id order by year,week) lw3Units,
lag(Revenue,1) over (partition by product_id order by year,week) lwRevenue,
lag(Revenue,2) over (partition by product_id order by year,week) lw2Revenue,
lag(Revenue,3) over (partition by product_id order by year,week) lw3Revenue
from
(select
p.product_id,
p.product_sku,
p.product_title,
p.category_L2,
week,
year,
q.image,
q.inventory,
q.mrp,
q.selling_price,
FORMAT_DATE('%Y-%W', p.date) dateweek,
sum(impressions) impressions,
sum(clicks) Clicks,
sum(productdetail_views) UPV,
sum(Addstocart) Addstocart,
sum(orders) sales,
sum(units) Units,
sum(revenue) Revenue,
min(p.date) Startdate,
max(p.date) Enddate,
from
(select product_id,category_L2,product_title,product_sku,date,week,year,FORMAT_DATE('%Y-%W', b.date) dateweek
from
(select distinct product_id,category_L2,product_title,product_sku from `noted-computing-279322.halo_1_1.fProductInsightsextended`) a, `noted-computing-279322.halo_1_1.Calendar` b ) p
left join
`noted-computing-279322.halo_1_1.fProductInsightsextended` q
on p.product_id=q.product_id and p.date=q.date_start
and p.product_sku = q.product_sku
and p.category_L2 = q.category_L2
and p.product_title = q.product_title
group by 1,2,3,4,5,6,7,8,9,10,11
)
) where week_year_no >= 2 and week_year_no<=15
)

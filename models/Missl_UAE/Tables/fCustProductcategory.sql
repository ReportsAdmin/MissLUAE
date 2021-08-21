select *,row_number() over (partition by user_id order by orders desc,revenue desc) Productcategory_rank,'MissLUAE' Halo_Country
from(
select  user_id,category_L1_id,count(distinct order_id) orders,sum(total_item_price) revenue,min(order_date) date_start,max(order_date) date_stop
from
(
select ord.order_date,ord.order_id,ord.total_item_price,ord.user_id,ord.product_id,cat.category_L1_id
from
`noted-computing-279322.halo_1_1_UAE.fOrders` ord,
`noted-computing-279322.halo_1_1_UAE.refProducts` cat
 where ord.product_id = cat.product_id
)
group by 1,2
)
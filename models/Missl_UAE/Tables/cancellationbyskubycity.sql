select distinct
pic,(sku_name),date_level_1 as date, ifnull(trim(lower(city)),'unknown') as city,ifnull(cancelled_prod_quantity,0) as cancelled_prod_quantity, ifnull(allorders_prod_quantity*100/(allorders_quantity),0) as percentage_overall_quantity, ifnull(successful_prod_quantity*100/ total_successful_quantity,0) as percentage_successful_quantity, ifnull(cancelled_prod_quantity*100/total_cancelled_quantity,0) as percentage_cancelled_quantity,ifnull(successful_prod_quantity,0) as successful_prod_quantity,ifnull(allorders_prod_quantity,0) as allorders_prod_quantity,ifnull(allorders_quantity,0) as allorders_quantity ,ifnull(total_successful_quantity,0) as total_successful_quantity ,ifnull(total_cancelled_quantity,0) as total_cancelled_quantity

from
(select distinct(cancelled.sku) as sku_name, sum(cancelled_prod_quantity) over(partition by cancelled.date_level_1) as total_cancelled_quantity,sum(successful_prod_quantity) over(partition by successful.date_level_1) as total_successful_quantity,sum(allorders_prod_quantity) over(partition by allorders.date_level_1) as allorders_quantity, cancelled.city as city,pic,cancelled.date_level_1,cancelled_prod_quantity,successful_prod_quantity,allorders_prod_quantity

from
(
-- cancelled orders
(select distinct (ord.product_sku) as SKU, ord.order_date as date_level_1,sum(case when order_status='canceled' then ord.product_quantity end) as cancelled_prod_quantity,ord.product_id as prodid,gallery.picture as pic,city
from
-- main data from A
((select product_sku, increment_id, product_id,order_status,order_date, product_quantity,city from `noted-computing-279322.halo_1_1_UAE.fOrders` as  orders) ord
left join
(select Product_id, Image as picture from `noted-computing-279322.halo_1_1_UAE.fProductImage` )gallery
on ord.product_id=gallery.Product_id
)
-- -- main data
group by 1,2,4,5,6) cancelled
-- -- cancelled_order
full outer join
-- -- successful_orders
(select distinct ord.product_sku as SKU, ord.order_date as date_level_1,sum(ord.product_quantity) as successful_prod_quantity,ord.product_id as prodid,gallery.picture,city
from
-- main data from A
((select product_sku, increment_id, product_id,order_status,order_date, product_quantity,city from `noted-computing-279322.halo_1_1_UAE.fOrders` as  orders) ord
left join
(select Product_id, Image as picture from `noted-computing-279322.halo_1_1_UAE.fProductImage` )gallery
on ord.product_id= gallery.Product_id
)
where ord.order_status='successful'
-- main data between these points A and B
group by 1,2,4,5,6)  successful
on cancelled.SKU=SUCCESSFUL.SKU and cancelled.date_level_1=successful.date_level_1 and cancelled.prodid=successful.prodid and cancelled.city=successful.city
full outer join
(select distinct ord.product_sku as SKU, ord.order_date as date_level_1,sum(ord.product_quantity) as allorders_prod_quantity,ord.product_id as prodid,gallery.picture,city
from
-- main data from A
((select product_sku, increment_id, product_id,order_status,order_date, product_quantity,city from `noted-computing-279322.halo_1_1_UAE.fOrders` as  orders) ord
left join
(select Product_id, Image as picture from `noted-computing-279322.halo_1_1_UAE.fProductImage` )gallery
on ord.product_id= gallery.Product_id
)
-- main data between these points A and B
group by 1,2,4,5,6) allorders
on cancelled.SKU=allorders.SKU and cancelled.date_level_1=allorders.date_level_1 and cancelled.prodid=allorders.prodid and cancelled.city=allorders.city
)
)
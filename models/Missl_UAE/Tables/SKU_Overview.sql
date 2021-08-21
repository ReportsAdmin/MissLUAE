Select tp.* except(city), city.mapped_city__st as city from
(Select topsell.*, price.price, live_dt.created_at as live_date from
(
select deli.*, inv.quantity, notify_stock_qty from
(select ord.*,(case when del.status like '%delivered%' then 1 else null end) as delivered from
(select distinct ord.product_sku as SKU, ord.order_date as date_level, increment_id,
cast(ord.product_id as INT64)as product_id, gallery.picture, city, sum(ord.product_quantity) as allorders_prod_quantity,
sum(case when ord.order_status='successful' then ord.product_quantity else null end) as successful_prod_quantity,
ifnull(sum(ord.total_item_price),0) as Overall_Revenue,
ifnull(sum(case when ord.order_status='successful' then ord.total_item_price else null end),0) as successful_revenue,
from (
(select product_sku, increment_id, product_id, order_status, order_date, product_quantity, Net_Revenue, total_item_price, ifnull(trim(lower(city)),'unknown') as city
from `noted-computing-279322.halo_1_1_UAE.fOrders` as orders) ord
left join
(select Product_id, Image as picture from `noted-computing-279322.halo_1_1_UAE.fProductImage`)gallery
on ord.product_id= gallery.Product_id
)
-- where ord.product_id = '896' and city = 'cairo'
-- main data between these points A and B
group by 1,2,3,4,5,6) ord
left join
(select status,increment_id
From `noted-computing-279322.halo_1_1_UAE.magento_transactionnew`
Where status like '%delivered%') del
on ord.increment_id = del.increment_id
) deli
left join
(Select quantity, cast(product_id as INT64) as product_id, notify_stock_qty from `noted-computing-279322.halo_1_1_UAE.magento_stock_status`) inv
on deli.product_id = inv.product_id
) topsell
left join
(select * from `noted-computing-279322.halo_1_1_UAE.magento_product_index_price`) price
on topsell.product_id = price.entity_id
left join
(select created_at,entity_id from `noted-computing-279322.halo_1_1_UAE.magento_productentity`) live_dt
on topsell.product_id = live_dt.entity_id
    ) tp
left join
(select * from `noted-computing-279322.city_corrected_name.City_Name`) city
on tp.city = city.current_city__st
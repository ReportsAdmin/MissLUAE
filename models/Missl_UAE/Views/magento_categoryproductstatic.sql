
select * from(
select *,row_number() over (partition by product_id,category_id order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.magento3_missl_live_catalog_category_product_static`
)
where row_number=1

select row_number() over() Devicecategory_id,Devicecategory,'MissLUAE' Halo_Country
from (
select distinct Devicecategory
from `noted-computing-279322.halo_1_1_UAE.fShoppingStages`
)
select a.date_start,b.ad_cat_id,c.Devicecategory_id,a.Allvisits,a.Productviews,a.Addstocart,a.Checkout,a.Shipping,a.PaymentOption,a.PaymentClick,a.Transactions,
       'MissLUAE' Halo_Country
from `noted-computing-279322.halo_1_1_UAE.fShoppingStages` a,`noted-computing-279322.halo_1_1_UAE.refKeywords` b,`noted-computing-279322.halo_1_1_UAE.refDeviceCategory` c
where a.keyword=b.keyword and a.adcontent=b.ad_content and a.campaign=b.campaign_name and a.Sourcemedium=b.source_medium
      and a.Devicecategory=c.Devicecategory

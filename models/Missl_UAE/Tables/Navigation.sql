
select *,  case when lower(D_ga_eventAction) like '%necklaces%' or lower(D_ga_eventAction) like '%ecklaces%' or lower(D_ga_eventAction) like '%nacklaces%' then 'Necklaces' when lower(D_ga_eventAction) like '%earrings%' then 'Earrings' when lower(D_ga_eventAction) like '%offer%' then 'Offer' when lower(D_ga_eventAction) like '%rings%' and lower(D_ga_eventAction) not like 'earrings%' then 'Rings'  when lower(D_ga_eventAction) like '%bracelets%' or lower(D_ga_eventAction) like '%racelets%' then 'Bracelets' when lower(D_ga_eventAction) like '%lady-fozaza%' or lower(D_ga_eventAction) like '%lady-foza-za%' or lower(D_ga_eventAction) like '%lady fawazza%' or D_ga_eventAction like '%ليدي فوزازا%' or D_ga_eventAction like '%سيدة فوزازة%' then 'Lady Fozaza' when lower(D_ga_eventAction) like '%shop-all-categories%' then 'Shop-All-Categories' when lower(D_ga_eventAction) like '%anklets%' then 'Anklets'  when lower(D_ga_eventAction) like '%best-seller%' then 'Best Sellers' when lower(D_ga_eventAction) like '%new-arrivals%' then 'New Arrivals' else 'others' end  Category ,'MissLUAE' Halo_Country from

(select StartDate,D_ga_eventCategory, D_ga_eventLabel  as D_ga_eventAction,sum(cast(M_ga_uniqueEvents as int64)) Nav
from `noted-computing-279322.halo_1_1_UAE.fGABaseEvents`
where  D_ga_eventCategory like '%navigation%'
group by 1,2,3
order by 1,2)
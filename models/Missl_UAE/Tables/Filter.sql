select distinct StartDate,sum(cast(M_ga_uniqueEvents as int64)) clicks,'MissLUAE' Halo_Country
from `noted-computing-279322.halo_1_1_UAE.fGABaseEvents`

  where D_ga_eventCategory in ('Filter','Filters')
group by 1,3
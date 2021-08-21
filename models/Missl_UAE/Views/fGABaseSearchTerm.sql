
select  * from (
SELECT * except(row_number)
FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY D_ga_date,D_ga_searchKeyword,D_ga_pagePath
                                                order by _daton_batch_runtime desc) row_number
FROM `noted-computing-279322.MissL1.missl_uae_ga_235620379_searchterm`)
WHERE row_number = 1
)


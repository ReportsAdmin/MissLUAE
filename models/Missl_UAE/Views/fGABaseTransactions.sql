

(select  * from
(select *except(sm_old,sm_ga,sm_expectation) from
(select *except(campaign_name), ifnull(sm_expectation,ifnull(sm_old,'')) D_ga_sourcemedium from
(select distinct *except(d_ga_sourcemedium),d_ga_sourcemedium as sm_old from
(select * except(row_number) from(
select * ,row_number() over(partition by D_ga_transactionId order by _daton_batch_runtime desc) row_number
from `noted-computing-279322.MissL1.missl_uae_transactions_235620379_transactions`)
where row_number=1))a
left join
(select distinct sm_ga,campaign_name,sm_expectation
from `noted-computing-279322.halo_1_1_UAE.channel_uae`)b
on a.D_ga_campaign = b.campaign_name and a.sm_old = b.sm_ga)
))












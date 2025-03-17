# Q
with info as (
	select *
	from cleaned_sales 
	where `Transaction Date` != ""
)
, 
running_metrics_per_month as
(
	select Month,`Transaction Date`, 
		sum(`Total Spent`) over (order by `Transaction Date`) as running_sum_per_month,
		count("Item") over(order by `Transaction Date`) as running_count_per_month
	from info
	order by FIELD(Month,'January','February', 'March', 'April',
	'May','June','July','August', 'September','October',
	'November', 'December')
)

select *
from running_metrics_per_month


    
    
#What is the top 3 selling item by each month and how much was spent on it?
with info as (
	select *
	from cleaned_sales 
	where `Transaction Date` != ""
)
,
grouped as (
	select Month, Item, sum(`Total Spent`) as Revenue
	from info
	group by Month, Item
	order by FIELD(Month,'January','February', 'March', 'April',
		'May','June','July','August', 'September','October',
		'November', 'December')
)
,
ranked as (
	select Month, Item, Revenue,
		rank() over (partition by Month order by Revenue desc) as ranking
	from grouped 
	order by FIELD(Month,'January','February', 'March', 'April',
		'May','June','July','August', 'September','October',
		'November', 'December'), Revenue desc
    )
    
select * 
from ranked
where ranking <=3
order by FIELD(Month,'January','February', 'March', 'April',
	'May','June','July','August', 'September','October',
	'November', 'December'), ranking
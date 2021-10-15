
-- We only need the last 2 years of data (which is 2016-2017), hence we only take the data after '2015-12-31'
create table customer_trx_new as
	select *
	from "customer trx" ct 
	where "Order Date" > '2015-12-31'
	order by "Order Date" asc 

-- Returned table only haas ID and region data, hence we most join with customer_trx_new to get some necessary columns
create table return_new as
	select 
	gr."Order ID",
	ctn."Order Date",
	ctn."Customer Name",
	ctn."Product Name",
	ctn.quantity,
	ctn."Sub-Category",
	ctn.category,
	ctn.city,
	ctn.country
	from gstore_return gr 
	left join customer_trx_new ctn 
	on gr."Order ID" = ctn."Order ID"

-- The returned table contains all-time returned products, because we join it with customer_trx_new(which only have 2016-2017 data), 
-- some values must be null. Hence we use where not null.
select * 
from return_new 
where "Product Name" notnull 




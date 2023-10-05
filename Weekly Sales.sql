


---------------------------------------------------------------------------------------------
                                                                    -- Sales Analysis
---------------------------------------------------------------------------------------------


alter table [Weekly_Saels_ 2015_2016]
add Sales_by_week_key money -- adding new column Sales by week

update [Weekly_Saels_ 2015_2016]
set Sales_by_week_key = ( CSP * Sales_Volume ) 

select sum(Sales_by_week_key)
from  [Weekly_Saels_ 2015_2016] -- total sales  6185251.2375


-- Sales by year
select 
( select sum(Sales_by_week_key) / 6185251.2375 * 100 as percent_of_total_sales_2016
from [Weekly_Saels_ 2015_2016]
where Week_Key like '2016%' ) as _2016_,
( select sum(Sales_by_week_key) / 6185251.2375 * 100 as percent_of_total_sales_2015
from [Weekly_Saels_ 2015_2016]
where Week_Key like '2015%' ) as _2015_
  -- 2016  27.8 % of total sales
  -- 2015  72.1 % of total sales 



-- Sales by Week Key
select  Week_Key ,sum(Sales_by_week_key / 6185251.2375 ) * 100 as percent_of_total_sales
from [Weekly_Saels_ 2015_2016]
group by Week_Key
order by Week_Key asc


-- Sales by channel
select Channel, sum( Sales_by_week_key / 6185251.2375 ) * 100 as percent_of_total_sales
from [Weekly_Saels_ 2015_2016]
group by Channel  -- Online  7.22 % 
                  -- Stores  92.7 %

-- Sales by countryID
select CountryID, sum( Sales_by_week_key / 6185251.2375 ) * 100 as percent_of_total_sales
from [Weekly_Saels_ 2015_2016]
group by CountryID
                -- A  7.60 %
				-- B  92.3 %


-- Sales by group
select p.[Group] ,sum(w.Sales_by_week_key) as profit_by_category, sum( w.Sales_by_week_key / 6185251.2375 ) * 100 as percent_of_total_sales 
from [Weekly_Saels_ 2015_2016] as w
join Products_table as p on w.ProductID = p.ProductID
group by p.[Group]

  --        Group	  percent_of_total_sales

-- highest 3bc0de94	         0.14 %
-- lowest  26387251	         43.5 %

 
---------------------------------------------------------------------------------------------
                                                     -- Number of products sold, stock
---------------------------------------------------------------------------------------------



select sum(Total_Stock_Volume) as total_stock, sum(Sales_Volume) as products_sold
from [Weekly_Saels_ 2015_2016]  -- total stock count across all stores  552950
                                -- total number of products sold 445408

-- % total number of products available on stock across all stores, total number of products sold by Group 
select p.[Group] , sum (w.Total_Stock_Volume) / 552950 * 100 as percent_of_total_stock_count,
sum(w.Sales_Volume) / 445408 * 100 as percent_of_total_products_sold
from [Weekly_Saels_ 2015_2016] as w
join Products_table as p on w.ProductID = p.ProductID
group by [Group]


-- % of total products sold by Week Key
select Week_Key, sum(Sales_Volume) / 445408 * 100  as percent_of_total_number_products_sold
from [Weekly_Saels_ 2015_2016]
group by Week_Key
order  by Week_Key asc




 




 





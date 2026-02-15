create database project_sql_1

use project_sql_1

drop table if exists  retail_sales
create table  retail_sales (
transactions_id int primary key , 
sale_date date ,
sale_time time ,
customer_id int ,
gender varchar(15) , 
age int , 
category varchar(25),
quantiy int , 
price_per_unit float , 
cogs float ,
total_sale float ,
)

SELECT TOP 10 * FROM [dbo].[retail sales];

select count(*) from [dbo].[retail sales]



-------------data cleaning ------------------

select * from [dbo].[retail sales]


select * from [dbo].[retail sales]
where transactions_id is null 

select * from [dbo].[retail sales]
where [sale_date] is null 

select * from [dbo].[retail sales]
where [sale_time] is null 

select * from [dbo].[retail sales]
where [customer_id] is null 

select * from [dbo].[retail sales]
where [gender] is null 

select * from [dbo].[retail sales]  --- null 
where [age] is null 

select * from [dbo].[retail sales]
where [category] is null 

select * from [dbo].[retail sales] --- null 
where [quantiy] is null

select * from [dbo].[retail sales] ----null 
where [price_per_unit] is null 

select * from [dbo].[retail sales] --- null 
where [cogs] is null 

select * from [dbo].[retail sales]  ---- null 
where  [total_sale] is null 



----2nd way 

select * from [dbo].[retail sales]
where
[category] is null 
or 
[cogs] is null 
or 
[total_sale] is null 


-----delete null 

delete from [dbo].[retail sales] 
where [price_per_unit] is null 
or
[cogs] is null 
or
[total_sale] is null 
or
[age] is null 


----check all data 
select * from [dbo].[retail sales]


select count(*) from [dbo].[retail sales]



---------------to check any null value in in this table -------
select * from [dbo].[retail sales]
where [transactions_id] is null
or [sale_date] is null 
or [sale_time] is null 
or [customer_id] is null 
or [gender] is null 
or [age] is null 
or [category] is null 
or [quantiy] is null 
or [price_per_unit] is null 
or [cogs] is null 
 or [total_sale] is null 


 ---------data exploration -------

 -----how many sales we have ------
 select count(*) [total count] from [dbo].[retail sales]

 ------ how many unique customers we have 
 select  count(distinct customer_id)[total cutsomers] from [dbo].[retail sales]

  ------ how many unique catgory we have 

select distinct category [total category] from [dbo].[retail sales]



--- data analysis and business key problems & answers 
select * from [dbo].[retail sales]

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

select *
from
[dbo].[retail sales]
where 
sale_date = '2022-11-05'

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 4 in the month of Nov-2022:
SELECT 
  *
FROM [dbo].[retail sales]
WHERE 
    category = 'Clothing'
    AND 
    FORMAT([sale_date], 'yyyy-MM') = '2022-11'
    AND
   quantiy >= 4;


---Write a SQL query to calculate the total sales (total_sale) for each category.:
select category, sum(total_sale) as net_sales, count(*) as total_order 
from [dbo].[retail sales]
group by category


----Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM [dbo].[retail sales]
WHERE total_sale > 1000


----Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select 
 ROUND(AVG(age), 2) as avg_age
from [dbo].[retail sales]
where category = 'beauty'



---- Write a SQL query to find the total number of transactions (transaction_id) 
-- made by each gender in each category.:

select gender , category , count(*) as total_transctions
from [dbo].[retail sales]
group by category , gender  


-----Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT 
    year,
    month,
    avg_sale
FROM 
(    
    SELECT 
        YEAR(sale_date) as year,
        MONTH(sale_date) as month,
        AVG(total_sale) as avg_sale,
        RANK() OVER(
            PARTITION BY YEAR(sale_date) 
            ORDER BY AVG(total_sale) DESC
        ) as rank
    FROM [dbo].[retail sales]
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) as t1
WHERE rank = 1;


-----**Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT TOP 5
    customer_id,
    SUM(total_sale) AS total_sales
FROM [dbo].[retail sales]
GROUP BY customer_id
ORDER BY total_sales DESC;


---Write a SQL query to find the number of unique customers who purchased items from each category.:
select count(distinct customer_id) as total, category 
from [dbo].[retail sales]
group by category 


----Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
with hourly_sale as (
select *, 
case 
when DATEPART(hour ,[sale_time])<12 then 'morning'
when datepart(hour , [sale_time])between 12 and 17 then ' evening'
else 'afternoon' 
end as shift
from [dbo].[retail sales]
)
select shift , count(*) as total_orders from hourly_sale
group by shift 

--Select all products with brand “Cacti Plus”
SELECT * FROM product WHERE brand='Cacti Plus';

--Count of total products with product category=”Skin Care”
SELECT COUNT(*) Category FROM product WHERE category='Skin care';

--Count of total products with MRP more than 100
SELECT COUNT(*) MRP FROM product WHERE mrp>100;

--Count of total products with product category=”Skin Care” and MRP more than 100
SELECT COUNT(*) FROM product WHERE category='Skin care' AND mrp>100;

--Brandwise product count
SELECT product.brand, COUNT(product.product_id) PRODUCT FROM product GROUP BY brand

--Brandwise as well as Active/Inactive Status wise product count
SELECT product.brand,
SUM(case when active = 'Y' then 1 else 0 end) as active,
SUM(case when active = 'N' then 1 else 0 end) as inactive,
COUNT(*) AS totals
FROM product GROUP BY brand

--Display all columns with Product category in Skin Care or Hair Care
SELECT * FROM product WHERE category='Skin Care' OR category='Hair Care';

--Display all columns with Product category in Skin Care or Hair Care, and MRP more than 100
SELECT * FROM product WHERE mrp>100 AND (category='Skin Care' OR category='Hair Care');

--Display   all   columns   with   Product   category=”Skin   Care”   and Brand=”Pondy”, and MRP more than 100
SELECT * FROM product WHERE mrp>100 AND (category='Skin Care' AND brand='Pondy');

--Display   all   columns   with   Product   category   =”Skin   Care”   or Brand=”Pondy”, and MRP more than 100
SELECT * FROM product WHERE mrp>100 AND (category='Skin Care' OR brand='Pondy');

--Display all product names only with names starting from letter P
SELECT product_name FROM product WHERE product_name LIKE 'P%'

--Display  all product  names only with names Having letters “Bar”  in Between
SELECT product_name FROM product WHERE product_name LIKE '%Bar%'

--Sales of those products which have been sold in more than two quantity in a bill
SELECT * FROM sales WHERE qty>2

--Sales of those products which have been sold in more than two quantity throughout the bill
SELECT product_id,sum(qty)FROM sales GROUP BY product_id HAVING sum(qty)>2 

--Create a new table with columns username and birthday, and dump data from dates file. Convert it to .csv format if required.
Create table employee(
username varchar(30),
birthday date
);

BULK INSERT dbo.employee
FROM 'C:\Users\aakritichapain\Downloads\date.csv'
WITH (
  FIRSTROW = 2,
  FIELDTERMINATOR = ',',
  ROWTERMINATOR ='\n'
)

--Research on Date Function Queries from the slide
--After populating the data, find no of people sharing Birth date Birth month Weekday
SELECT COUNT(username) FROM employee
WHERE birthday IN (
  SELECT birthday FROM employee
  GROUP BY birthday
  HAVING COUNT(birthday) > 1
)

SELECT DATEPART(MONTH, birthday) as Months, COUNT(*) as Number_of_People
FROM employee
GROUP BY DATEPART(MONTH, birthday)
HAVING count(*)>1

SELECT DATEPART(WEEKDAY, birthday) as Week, COUNT(*) as Number_of_People
FROM employee
GROUP BY DATEPART(WEEKDAY, birthday)
HAVING count(*)>1


--Find the current age of all people
SELECT *, DATEDIFF(year, birthday, GETDATE()) Age FROM employee

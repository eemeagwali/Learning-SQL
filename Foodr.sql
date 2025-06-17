SELECT * FROM meals

--1. Calculating Revenue 
SELECT  
  order_id,  
  SUM(meal_price * order_quantity) AS revenue  
FROM meals  
JOIN orders ON meals.meal_id = orders.meal_id  
GROUP BY order_id;

--2. Calculating Cost 
SELECT  
  meals.meal_id,   
  SUM(meal_cost * stocked_quantity) AS cost   
FROM meals  
JOIN stock ON meals.meal_id = stock.meal_id  
GROUP BY meals.meal_id, meals.meal_cost  
ORDER BY meals.meal_cost DESC  
LIMIT 3;

--3. Using Common Table Expressions (CTEs) 
--WITH costs_and_quantities AS (  
WITH costs_and_quantities AS (  
 SELECT  
   meals.meal_id,  
   SUM(stocked_quantity) AS quantity,  
   SUM(meal_cost * stocked_quantity) AS cost  
 FROM meals  
 JOIN stock ON meals.meal_id = stock.meal_id  
 GROUP BY meals.meal_id 
)   
SELECT   
 meal_id,  
 quantity,  
 cost  
FROM costs_and_quantities  
ORDER BY cost DESC  
LIMIT 3;


--4. Bringing Revenue and Cost Together -> and Calculating Profit
WITH revenue AS (  
  SELECT  
    meals.meal_id,  
    SUM(meal_price * order_quantity) AS revenue  
  FROM meals  
  JOIN orders ON meals.meal_id = orders.meal_id  
  GROUP BY meals.meal_id 
),   
cost AS (  
  SELECT  
    meals.meal_id,  
    SUM(meal_cost * stocked_quantity) AS cost  
  FROM meals  
  JOIN stock ON meals.meal_id = stock.meal_id  
  GROUP BY meals.meal_id 
)
SELECT  
  revenue.meal_id,  
  revenue,  
  cost,  
  revenue - cost AS profit  
FROM revenue  
JOIN cost ON revenue.meal_id = cost.meal_id  
ORDER BY profit DESC  
LIMIT 3;

Part 2


--1. Registrations - setup
SELECT 
  user_id, 
  MIN(order_date) AS reg_date 
FROM orders 
GROUP BY user_id 
ORDER BY user_id 
LIMIT 3;

--2. Registrations - query
WITH reg_dates AS ( 
  SELECT 
    user_id, 
    MIN(order_date) AS reg_date 
  FROM orders 
  GROUP BY user_id) 
SELECT 
  DATE_TRUNC('month', reg_date) :: DATE AS foodr_month, 
  COUNT(DISTINCT user_id) AS regs 
FROM reg_dates 
GROUP BY foodr_month 
ORDER BY foodr_month ASC 
LIMIT 3;

--3. Active users - query
SELECT 
  DATE_TRUNC('month', order_date) :: DATE AS foodr_month, 
  COUNT(DISTINCT user_id) AS mau 
FROM orders 
GROUP BY foodr_month 
ORDER BY foodr_month ASC 
LIMIT 3;

--4. Registrations running total - query
WITH reg_dates AS ( 
  SELECT 
    user_id, 
    MIN(order_date) AS reg_date 
  FROM orders 
  GROUP BY user_id),  
  registrations AS ( 
  SELECT 
    DATE_TRUNC('month', reg_date) :: DATE AS foodr_month, 
    COUNT(DISTINCT user_id) AS regs 
  FROM reg_dates 
  GROUP BY foodr_month)  
SELECT 
  foodr_month, 
  regs, 
  SUM(regs) OVER (ORDER BY foodr_month ASC) AS regs_rt 
FROM registrations 
ORDER BY foodr_month ASC 
LIMIT 3;


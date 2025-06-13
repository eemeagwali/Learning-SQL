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


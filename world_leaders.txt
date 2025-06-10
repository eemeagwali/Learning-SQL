 


SELECT COUNT(name) AS count_names, COUNT(birthdate) AS count_birthdates
FROM people;

SELECT COUNT(*) AS total_records
FROM people;

SELECT language
FROM films;

SELECT DISTINCT language
FROM films;

SELECT COUNT(DISTINCT birthdate) AS count_distinct_birthdates
FROM people;

SELECT name
FROM people
LIMIT 10;




-- Basic WHERE Clause
SELECT title 
FROM films 
WHERE release_year > 1960;

SELECT title 
FROM films 
WHERE release_year < 1960;

SELECT title 
FROM films 
WHERE release_year <= 1960;

SELECT title 
FROM films 
WHERE release_year = 1960;

SELECT title 
FROM films 
WHERE release_year <> 1960;

SELECT title 
FROM films 
WHERE country = 'Japan';

SELECT item 
FROM coats 
WHERE color = 'green' 
LIMIT 5;

-- Multiple Criteria (AND, OR, BETWEEN)
SELECT * 
FROM coats 
WHERE color = 'yellow' OR length = 'short';

SELECT * 
FROM coats 
WHERE color = 'yellow' AND length = 'short';

SELECT * 
FROM coats 
WHERE buttons BETWEEN 1 AND 5;

SELECT title 
FROM films 
WHERE release_year = 1994 
    OR release_year = 2000;

-- Invalid
-- SELECT title 
-- FROM films 
-- WHERE release_year = 1994 OR 2000;

SELECT title 
FROM films 
WHERE release_year > 1994 
    AND release_year < 2000;

-- Invalid
-- SELECT title 
-- FROM films 
-- WHERE release_year > 1994 AND < 2000;

SELECT title 
FROM films 
WHERE (release_year = 1994 OR release_year = 1995) 
    AND (certification = 'PG' OR certification = 'R');

SELECT title 
FROM films 
WHERE release_year >= 1994 
    AND release_year <= 2000;

SELECT title 
FROM films 
WHERE release_year 
    BETWEEN 1994 AND 2000;

SELECT title 
FROM films 
WHERE release_year 
BETWEEN 1994 AND 2000 AND country='UK';

-- Pattern Matching (LIKE, NOT LIKE, IN)
SELECT title 
FROM films 
WHERE country = 'Japan';

SELECT name 
FROM people 
WHERE name LIKE 'Ade%';

SELECT name 
FROM people 
WHERE name LIKE 'Ev_';

SELECT name 
FROM people 
WHERE name NOT LIKE 'A.%';

SELECT name 
FROM people 
WHERE name LIKE '%r';

SELECT name 
FROM people 
WHERE name LIKE '__t%';

SELECT title 
FROM films 
WHERE release_year = 1920 
OR release_year = 1930 
OR release_year = 1940;

SELECT title 
FROM films 
WHERE release_year IN (1920, 1930, 1940);

SELECT title 
FROM films 
WHERE country IN ('Germany', 'France');

-- NULL Handling
SELECT COUNT(*) AS count_records 
FROM people;

SELECT * 
FROM people;

SELECT name 
FROM people 
WHERE birthdate IS NULL;

SELECT COUNT(*) AS no_birthdates 
FROM people 
WHERE birthdate IS NULL;

SELECT COUNT(name) AS count_birthdates 
FROM people 
WHERE birthdate IS NOT NULL;

SELECT  
   COUNT(certification)  
   AS count_certification 
FROM films;

SELECT  
   COUNT(certification)  
   AS count_certification 
FROM films 
WHERE certification IS NOT NULL;


**********************

-- Aggregate functions
SELECT AVG(budget) 
FROM films;

SELECT SUM(budget) 
FROM films;

SELECT MIN(budget) 
FROM films;

SELECT MAX(budget) 
FROM films;

-- Non-numerical data
SELECT MIN(country) 
FROM films;

SELECT MAX(country) 
FROM films;

-- Aliasing
SELECT MIN(country) AS min_country 
FROM films;

-- Using WHERE with aggregate functions
SELECT AVG(budget) AS avg_budget 
FROM films 
WHERE release_year >= 2010;

SELECT SUM(budget) AS sum_budget 
FROM films 
WHERE release_year = 2010;

SELECT MIN(budget) AS min_budget 
FROM films 
WHERE release_year = 2010;

SELECT MAX(budget) AS max_budget 
FROM films 
WHERE release_year = 2010;

SELECT COUNT(budget) AS count_budget 
FROM films 
WHERE release_year = 2010;

-- ROUND()
SELECT ROUND(AVG(budget), 2) AS avg_budget 
FROM films 
WHERE release_year >= 2010;

SELECT ROUND(AVG(budget)) AS avg_budget 
FROM films 
WHERE release_year >= 2010;

SELECT ROUND(AVG(budget), 0) AS avg_budget 
FROM films 
WHERE release_year >= 2010;

SELECT ROUND(AVG(budget), -5) AS avg_budget 
FROM films 
WHERE release_year >= 2010;

-- Arithmetic
SELECT (4 + 3);

SELECT (4 * 3);

SELECT (4 - 3);

SELECT (4 / 3);

SELECT (4.0 / 3.0);

-- Aliasing with arithmetic
SELECT (gross - budget) 
FROM films;

SELECT (gross - budget) AS profit 
FROM films;

-- Aliasing with functions
SELECT MAX(budget), MAX(duration) 
FROM films;

SELECT MAX(budget) AS max_budget, 
       MAX(duration) AS max_duration 
FROM films;

-- Order of execution (invalid query example)
-- SELECT budget AS max_budget 
-- FROM films 
-- WHERE max_budget IS NOT NULL;



-- ORDER BY
SELECT title, budget 
FROM films 
ORDER BY budget;

SELECT title, budget 
FROM films 
ORDER BY title;

SELECT title, budget 
FROM films 
ORDER BY budget ASC;

SELECT title, budget 
FROM films 
ORDER BY budget DESC;

SELECT title, budget 
FROM films 
WHERE budget IS NOT NULL 
ORDER BY budget DESC;

SELECT title 
FROM films 
ORDER BY release_year;

SELECT title, release_year 
FROM films 
ORDER BY release_year;

-- ORDER BY multiple fields
SELECT title, wins 
FROM best_movies 
ORDER BY wins DESC;

SELECT title, wins, imdb_score 
FROM best_movies 
ORDER BY wins DESC, imdb_score DESC;

-- Different orders
SELECT birthdate, name 
FROM people 
ORDER BY birthdate, name DESC;

-- ORDER BY with LIMIT
SELECT item 
FROM coats 
WHERE color = `yellow` 
ORDER BY length 
LIMIT 3;

-- GROUP BY single fields
SELECT certification, COUNT(title) AS title_count 
FROM films 
GROUP BY certification;

-- Error example
-- SELECT certification, title 
-- FROM films 
-- GROUP BY certification;

-- Corrected query
SELECT certification, COUNT(title) AS count_title 
FROM films 
GROUP BY certification;

-- GROUP BY multiple fields
SELECT certification, language, COUNT(title) AS title_count 
FROM films 
GROUP BY certification, language;

-- GROUP BY with ORDER BY
SELECT certification, COUNT(title) AS title_count 
FROM films 
GROUP BY certification 
ORDER BY title_count DESC;

-- GROUP BY with ORDER BY and LIMIT
SELECT certification, COUNT(title) AS title_count 
FROM films 
GROUP BY certification 
ORDER BY title_count DESC 
LIMIT 3;

-- HAVING
-- Invalid query
-- SELECT release_year, COUNT(title) AS title_count 
-- FROM films 
-- GROUP BY release_year 
-- WHERE COUNT(title) > 10;

-- Corrected query
SELECT release_year, COUNT(title) AS title_count 
FROM films 
GROUP BY release_year 
HAVING COUNT(title) > 10;

-- Full example with WHERE, GROUP BY, HAVING, ORDER BY, LIMIT
SELECT certification, COUNT(title) AS title_count 
FROM films 
WHERE certification IN ('G', 'PG', 'PG-13') 
GROUP BY certification 
HAVING COUNT(title) > 500 
ORDER BY title_count DESC 
LIMIT 3;

-- HAVING vs WHERE
SELECT title 
FROM films 
WHERE release_year = 2000;

SELECT release_year 
FROM films  
GROUP BY release_year  
HAVING AVG(duration) > 120;



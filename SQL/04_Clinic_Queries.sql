-- Q1 Revenue by channel
SELECT 
sales_channel,
SUM(amount) total_revenue
FROM clinic_sales
WHERE YEAR(datetime)=2021
GROUP BY sales_channel;


-- Q2 Top 10 customers
SELECT 
uid,
SUM(amount) total_spent
FROM clinic_sales
WHERE YEAR(datetime)=2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;


-- Q3 Month wise profit
WITH revenue AS(
SELECT 
MONTH(datetime) month,
SUM(amount) revenue
FROM clinic_sales
GROUP BY MONTH(datetime)
),

expense AS(
SELECT 
MONTH(datetime) month,
SUM(amount) expense
FROM expenses
GROUP BY MONTH(datetime)
)

SELECT 
r.month,
r.revenue,
e.expense,
(r.revenue-e.expense) profit,
CASE 
WHEN (r.revenue-e.expense)>0 THEN 'Profit'
ELSE 'Loss'
END status
FROM revenue r
JOIN expense e ON r.month=e.month;


-- Q4 Most profitable clinic per city
WITH data AS(
SELECT 
c.city,
c.cid,
SUM(cs.amount)-SUM(e.amount) profit
FROM clinics c
JOIN clinic_sales cs ON c.cid=cs.cid
JOIN expenses e ON c.cid=e.cid
GROUP BY c.city,c.cid
),

ranked AS(
SELECT *,
RANK() OVER(PARTITION BY city ORDER BY profit DESC) rnk
FROM data
)

SELECT *
FROM ranked
WHERE rnk=1;


-- Q5 Second least profitable clinic per state
WITH data AS(
SELECT 
c.state,
c.cid,
SUM(cs.amount)-SUM(e.amount) profit
FROM clinics c
JOIN clinic_sales cs ON c.cid=cs.cid
JOIN expenses e ON c.cid=e.cid
GROUP BY c.state,c.cid
),

ranked AS(
SELECT *,
RANK() OVER(PARTITION BY state ORDER BY profit ASC) rnk
FROM data
)

SELECT *
FROM ranked
WHERE rnk=2;

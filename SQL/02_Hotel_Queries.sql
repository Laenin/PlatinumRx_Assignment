-- Q1 Last booked room for every user
SELECT 
    b.user_id,
    b.room_no
FROM bookings b
JOIN (
    SELECT user_id, MAX(booking_date) last_booking
    FROM bookings
    GROUP BY user_id
) x
ON b.user_id=x.user_id 
AND b.booking_date=x.last_booking;


-- Q2 Total billing amount in Nov 2021
SELECT 
    bc.booking_id,
    SUM(bc.item_quantity*i.item_rate) total_bill
FROM booking_commercials bc
JOIN items i ON bc.item_id=i.item_id
WHERE MONTH(bc.bill_date)=11
AND YEAR(bc.bill_date)=2021
GROUP BY bc.booking_id;


-- Q3 Bills >1000 in Oct 2021
SELECT 
    bc.bill_id,
    SUM(bc.item_quantity*i.item_rate) bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id=i.item_id
WHERE MONTH(bc.bill_date)=10
AND YEAR(bc.bill_date)=2021
GROUP BY bc.bill_id
HAVING bill_amount>1000;


-- Q4 Most and least ordered item each month
WITH item_count AS(
SELECT 
MONTH(bill_date) month,
item_id,
SUM(item_quantity) total_qty
FROM booking_commercials
WHERE YEAR(bill_date)=2021
GROUP BY MONTH(bill_date),item_id
),

ranked AS(
SELECT *,
RANK() OVER(PARTITION BY month ORDER BY total_qty DESC) most_rank,
RANK() OVER(PARTITION BY month ORDER BY total_qty ASC) least_rank
FROM item_count
)

SELECT *
FROM ranked
WHERE most_rank=1 OR least_rank=1;


-- Q5 Second highest bill each month
WITH bill_data AS(
SELECT 
b.user_id,
MONTH(bc.bill_date) month,
SUM(bc.item_quantity*i.item_rate) total_bill
FROM booking_commercials bc
JOIN bookings b ON bc.booking_id=b.booking_id
JOIN items i ON bc.item_id=i.item_id
WHERE YEAR(bc.bill_date)=2021
GROUP BY b.user_id,MONTH(bc.bill_date)
),

ranked AS(
SELECT *,
DENSE_RANK() OVER(PARTITION BY month ORDER BY total_bill DESC) rnk
FROM bill_data
)

SELECT *
FROM ranked
WHERE rnk=2;

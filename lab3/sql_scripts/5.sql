SELECT "bill_ID", date, price, use_time
FROM bill
GROUP BY "bill_ID" HAVING MIN(date) < '2005.04.07';
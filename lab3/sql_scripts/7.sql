SELECT 
	boat."boat_type",
	AVG(price) AS "сред. цена"
FROM bill
JOIN
	boat ON bill."boat_ID" = boat."boat_ID"
GROUP BY
	boat."boat_type"
HAVING AVG(price) >= 1300;
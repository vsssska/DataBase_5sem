SELECT EXTRACT(MONTH FROM date) AS "Month", COUNT(*) AS "Count"
FROM bill
GROUP BY EXTRACT(MONTH FROM date)
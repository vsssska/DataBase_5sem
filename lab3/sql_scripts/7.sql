SELECT MIN(price) AS "мин. цена",
MAX(price) AS "макс. цена", AVG(price) "сред. цена"
FROM bill
HAVING AVG(price) <= 1600;
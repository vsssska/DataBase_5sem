SELECT gender, age, COUNT(*) AS "Кол-во"
FROM buyer
GROUP BY gender, age;
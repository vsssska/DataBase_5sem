SELECT gender, COUNT(*) AS "Кол-во полов"
FROM buyer
GROUP BY gender;
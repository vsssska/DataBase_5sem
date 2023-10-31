SELECT
	s."seller_name",
	SUM(b."price")/35 AS "price $"
FROM
	bill b
JOIN
	buyer buy ON b."buyer_ID" = buy."buyer_ID"
JOIN
	seller s ON b."seller_ID" = s."seller_ID"
GROUP BY
	s."seller_name"
ORDER BY
	"price $" ASC;

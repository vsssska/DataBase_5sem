SELECT
	buy."second_name",
	SUM(b."price")/30 AS "price $"
FROM
	bill b
JOIN
	buyer buy ON b."buyer_ID" = buy."buyer_ID"
JOIN
	seller s ON b."seller_ID" = s."seller_ID"
GROUP BY
	buy."second_name"
ORDER BY
	"price $" DESC;
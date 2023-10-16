SELECT 
	b."bill_ID",
	buy."second_name",
	s."seller_name"
FROM
	bill b
JOIN
	buyer buy ON b."buyer_ID" = buy."buyer_ID"
JOIN
	seller s ON b."seller_ID" = s."seller_ID"
ORDER BY
	buy.second_name ASC;

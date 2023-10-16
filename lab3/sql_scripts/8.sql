SELECT 
	s.seller_name,
	buy.second_name,
	COUNT(b."bill_ID") AS total_bill
FROM
	bill b
JOIN
	seller s ON b."seller_ID" = s."seller_ID"
JOIN
	buyer buy ON b."buyer_ID" = buy."buyer_ID"
GROUP BY
	s.seller_name, buy.second_name;
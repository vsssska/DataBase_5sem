SELECT "date", "use_time", "second_name", "seller_name"
FROM "bill"
INNER JOIN "buyer" 
ON "buyer"."buyer_ID" = "bill"."buyer_ID"
INNER JOIN "seller"
ON "seller"."seller_ID" = "bill"."seller_ID" 
WHERE "bill"."seller_ID" > 1
AND "bill"."date" > '2005-01-03'
AND "use_time" > 1

SELECT "date", "use_time", "second_name"
FROM "bill"
INNER JOIN "buyer" 
ON "buyer"."buyer_ID" = "bill"."buyer_ID"
INNER JOIN "seller"
ON "seller"."seller_ID" = "bill"."seller_ID"
WHERE "bill"."date" > '2005-01-03'
AND "use_time" > 3
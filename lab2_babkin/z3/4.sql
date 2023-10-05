SELECT "date", "use_time", "price", "gender", "second_name", "seller_name", "age"
FROM "bill"
INNER JOIN "buyer" 
ON "bill"."buyer_ID" = "buyer"."buyer_ID"
INNER JOIN "seller"
ON "seller"."seller_ID" = "bill"."seller_ID"
WHERE "gender" = 'женский'
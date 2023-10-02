SELECT "date", "use_time", "price", "gender", "second_name", "age"
FROM "bill"
FULL JOIN "buyer"
ON "bill"."buyer_ID" = "buyer"."buyer_ID"
FULL JOIN "seller" 
ON "bill"."seller_ID" = "seller"."seller_ID"


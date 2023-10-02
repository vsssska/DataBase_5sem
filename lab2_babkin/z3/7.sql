SELECT "date", "use_time", "price", "gender", "second_name", "age"
FROM "buyer"
RIGHT JOIN "bill" 
ON "bill"."buyer_ID" = "buyer"."buyer_ID"



SELECT "date", "use_time", "price", "gender", "second_name", "age"
FROM "bill"
LEFT JOIN "buyer" 
ON "bill"."buyer_ID" = "buyer"."buyer_ID"




SELECT "date", "use_time", "price", "gender", "second_name", "age"
FROM "bill"
INNER JOIN "buyer" 
ON "bill"."buyer_ID" = "buyer"."buyer_ID"
WHERE "bill"."date" >= '2005-01-04' AND "bill"."date" <= '2005-04-03'
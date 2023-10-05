SELECT "date", "second_name", "use_time"
FROM "bill"
INNER JOIN "buyer" 
ON "buyer"."buyer_ID" = "bill"."buyer_ID"
WHERE "bill"."date" > '2005-01-04'
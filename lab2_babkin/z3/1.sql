SELECT "date"
FROM "bill"
INNER JOIN "buyer" 
ON "buyer"."buyer_ID" = "bill"."buyer_ID";
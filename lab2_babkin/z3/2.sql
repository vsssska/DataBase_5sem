SELECT "date", "use_time", "bill_ID"
FROM "bill"
INNER JOIN "buyer" 
ON "buyer"."buyer_ID" = "bill"."buyer_ID"
INNER JOIN "seller"
ON "seller"."seller_ID" = "bill"."seller_ID";
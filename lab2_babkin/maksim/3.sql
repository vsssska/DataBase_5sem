SELECT *
FROM orders 
INNER JOIN vendors
ON orders.vendor_id = vendors.vendor_id
INNER JOIN sex
ON vendors.sex_id =sex.sex_id
WHERE sex.sex_id = 1;
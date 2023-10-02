SELECT order_date, order_count, vendor_name, vendor_job, sex_name
FROM orders 
INNER JOIN vendors
ON orders.vendor_id = vendors.vendor_id
INNER JOIN sex
ON vendors.sex_id =sex.sex_id
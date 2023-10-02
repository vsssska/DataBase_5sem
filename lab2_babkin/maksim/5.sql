SELECT order_date, order_count, vendor_name, vendor_job
FROM orders 
INNER JOIN vendors
ON orders.vendor_id = vendors.vendor_id
WHERE orders.order_date >= '2007-01-01' AND orders.order_date <= '2008-01-01'
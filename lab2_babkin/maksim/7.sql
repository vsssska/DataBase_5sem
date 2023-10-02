SELECT order_date, order_count, vendor_name, vendor_job
FROM orders 
RIGHT JOIN vendors
ON orders.order_count = vendors.vendor_id
CREATE OR REPLACE FUNCTION	Period(date_from date, date_to date)
RETURNS TABLE (
    order_id integer,
    order_date date,
    monitor_id integer,
    order_count integer,
    vendor_id integer
)
LANGUAGE plpgsql
AS $$
BEGIN
	RETURN QUERY
    SELECT *
    FROM public.orders
    WHERE order_date BETWEEN start_date AND end_date;
END;
$$
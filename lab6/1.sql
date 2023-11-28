CREATE OR REPLACE FUNCTION	Period(start_date date, end_date date)
RETURNS TABLE (
    order_date date,
    order_price integer,
	use_time integer,
    order_id integer,
    boat_id integer,
	buyer_id integer,
    vendor_id integer
)
AS $$
BEGIN
	RETURN QUERY
    SELECT *
    FROM public.orders
    WHERE public.orders.order_date BETWEEN start_date AND end_date;
END;
$$ LANGUAGE plpgsql;



SELECT * FROM Period('2005-01-03'::date, '2005-04-04'::date);
CREATE OR REPLACE FUNCTION row_count(date_from date, date_to date)
RETURNS int
LANGUAGE plpgsql
AS $$
DECLARE
   date_count integer;
BEGIN
	SELECT COUNT(*) 
    INTO date_count
    FROM public.orders
    WHERE order_date BETWEEN date_from AND date_to;
	return date_count;
END;
$$;

SELECT row_count('2005-01-01', '2005-04-04');
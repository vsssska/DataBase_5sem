CREATE OR REPLACE FUNCTION Sum_object(minimum_order_count integer)
RETURNS TABLE (
    monitor_brand character varying(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT m.monitor_brand
    FROM public.monitors m
    JOIN public.orders o ON m.monitor_id = o.monitor_id
    GROUP BY m.monitor_brand
    HAVING SUM(o.order_count) > minimum_order_count
	ORDER BY m.monitor_brand ASC;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM Sum_object(9);

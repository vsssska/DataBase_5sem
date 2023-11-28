DROP FUNCTION sum_object(integer);
CREATE OR REPLACE FUNCTION Sum_object(minimum_order_price integer)
RETURNS TABLE (
    buyer_name character varying(255)
) AS $$
BEGIN
    RETURN QUERY
    SELECT m.buyer_name
    FROM public.buyers m
    JOIN public.orders o ON m.buyer_id = o.buyer_id
    GROUP BY m.buyer_name
    HAVING SUM(o.order_price) > minimum_order_price
	ORDER BY m.buyer_name ASC;
END;
$$ LANGUAGE plpgsql;
SELECT * FROM Sum_object(1500);

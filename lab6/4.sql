CREATE OR REPLACE PROCEDURE object_stat(object_name character varying)
LANGUAGE plpgsql
AS $$
DECLARE
   min_value numeric;
   max_value numeric;
   avg_value numeric;
BEGIN
   -- Подсчет минимального значения
   SELECT MIN(o.order_price)
   INTO min_value
   FROM public.orders o
   JOIN public.buyers b ON o.buyer_id = b.buyer_id
   WHERE b.buyer_name = object_name;

   -- Подсчет максимального значения
   SELECT MAX(o.order_price)
   INTO max_value
   FROM public.orders o
   JOIN public.buyers b ON o.buyer_id = b.buyer_id
   WHERE b.buyer_name = object_name;

   -- Подсчет среднего значения
   SELECT AVG(o.order_price)
   INTO avg_value
   FROM public.orders o
   JOIN public.buyers b ON o.buyer_id = b.buyer_id
   WHERE b.buyer_name = object_name;

   -- Вывод результатов
   RAISE NOTICE 'Min Value: %, Max Value: %, Avg Value: %', min_value, max_value, avg_value;
END;
$$;

-- Вызов процедуры
CALL object_stat('Гришина');

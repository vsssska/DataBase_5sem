CREATE OR REPLACE PROCEDURE object_stat(object_name character varying)
LANGUAGE plpgsql
AS $$
DECLARE
   min_value numeric;
   max_value numeric;
   avg_value numeric;
BEGIN
   -- Подсчет минимального значения
   SELECT MIN(monitor_price)
   INTO min_value
   FROM public.monitors
   WHERE monitor_brand = object_name;

   -- Подсчет максимального значения
   SELECT MAX(monitor_price)
   INTO max_value
   FROM public.monitors
   WHERE monitor_brand = object_name;

   -- Подсчет среднего значения
   SELECT AVG(monitor_price)
   INTO avg_value
   FROM public.monitors
   WHERE monitor_brand = object_name;

   -- Вывод результатов
   RAISE NOTICE 'Min Value: %, Max Value: %, Avg Value: %', min_value, max_value, avg_value;
END;
$$;

-- Вызов процедуры
CALL object_stat('Самсунг');

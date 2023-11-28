CREATE OR REPLACE PROCEDURE objects_stat()
LANGUAGE plpgsql
AS $$
DECLARE
    parent_object_name VARCHAR(255);
    min_val DECIMAL(10, 2);
    max_val DECIMAL(10, 2);
    avg_val DECIMAL(10, 2);
BEGIN
    -- Выполняем запросы для вычисления минимального, максимального и среднего значения
    FOR parent_object_name IN (SELECT buyer_name FROM public.buyers)
    LOOP
		SELECT
			MIN(order_price), MAX(order_price), AVG(order_price)
		INTO
			min_val, max_val, avg_val
		FROM public.orders
		WHERE buyer_id = (SELECT buyer_id FROM public.buyers WHERE buyer_name = parent_object_name);

		-- Выводим результат
		RAISE NOTICE 'Object: %, Min: %, Max: %, Avg: %', parent_object_name, min_val, max_val, avg_val;
	END LOOP;
END;
$$;
-- Пример вызова процедуры
CALL objects_stat();

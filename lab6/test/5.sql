CREATE OR REPLACE PROCEDURE objects_stat(parent_object_name character varying)
LANGUAGE plpgsql
AS $$
DECLARE
   child_object_name character varying;
   min_value numeric;
   max_value numeric;
   avg_value numeric;
BEGIN
   -- Для каждого объекта в дочерней таблице
   FOR child_object_name IN (SELECT DISTINCT monitor_brand FROM public.monitors WHERE monitor_brand = parent_object_name)
   LOOP
      -- Подсчет минимального значения
      SELECT MIN(monitor_price)
      INTO min_value
      FROM public.monitors
      WHERE monitor_brand = child_object_name;

      -- Подсчет максимального значения
      SELECT MAX(monitor_price)
      INTO max_value
      FROM public.monitors
      WHERE monitor_brand = child_object_name;

      -- Подсчет среднего значения
      SELECT AVG(monitor_price)
      INTO avg_value
      FROM public.monitors
      WHERE monitor_brand = child_object_name;

      -- Вывод результатов
      RAISE NOTICE 'Object: %, Min Value: %, Max Value: %, Avg Value: %', child_object_name, min_value, max_value, avg_value;
   END LOOP;
END;
$$;

-- Пример вызова процедуры
CALL objects_stat('Эйсер');

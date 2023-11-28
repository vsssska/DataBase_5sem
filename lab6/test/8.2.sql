CREATE OR REPLACE FUNCTION before_delete_trigger()
RETURNS TRIGGER AS $$
DECLARE
    monitor_brand_value VARCHAR(255);
BEGIN
    -- Получаем имя объекта из родительской таблицы
    SELECT monitor_brand INTO monitor_brand_value FROM public.orders WHERE monitor_id = OLD.monitor_id;
    
    -- Выводим имя объекта из родительской таблицы
    RAISE NOTICE 'Удаляется объект с именем: %', monitor_brand_value;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_delete_orders
BEFORE DELETE ON public.monitors
FOR EACH ROW
EXECUTE FUNCTION before_delete_trigger();

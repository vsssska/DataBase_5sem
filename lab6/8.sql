CREATE OR REPLACE FUNCTION before_delete_trigger()
RETURNS TRIGGER AS $$
DECLARE
    parent_object_name TEXT;
BEGIN
    -- Получаем имя объекта родительской таблицы
    SELECT boat_type INTO parent_object_name
    FROM public.boats
    WHERE boat_id = OLD.boat_id;

    -- Проверяем на NULL и выводим сообщение
    IF parent_object_name IS NOT NULL THEN
        RAISE NOTICE 'delete object with name: %', parent_object_name;
    ELSE
        RAISE NOTICE 'delete object, but name undefined';
    END IF;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Создание триггера
CREATE TRIGGER before_delete_trigger
BEFORE DELETE ON public.orders
FOR EACH ROW
EXECUTE FUNCTION before_delete_trigger(); 

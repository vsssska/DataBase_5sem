-- Создание триггера AFTER DELETE
CREATE OR REPLACE FUNCTION delete_child_records()
RETURNS TRIGGER AS $$
BEGIN
    -- Удаляем записи из дочерней таблицы, связанные с удаляемой записью из родительской таблицы
    DELETE FROM public.orders
    WHERE boat_id = OLD.boat_id;

    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Создание самого триггера
CREATE TRIGGER after_delete_trigger
AFTER DELETE ON public.boats
FOR EACH ROW
EXECUTE FUNCTION delete_child_records();

CREATE OR REPLACE FUNCTION ins_sum()
RETURNS TRIGGER AS $$
BEGIN
    -- Используйте COALESCE, чтобы обработать NULL значения
    NEW.monitor_price := COALESCE(NEW.monitor_price, 0);

    -- Обновите monitor_price в каждой вставленной строке
    UPDATE monitors
    SET monitor_price = monitor_price + NEW.monitor_price;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создайте триггер, который будет активироваться перед каждой вставкой в таблицу monitors
CREATE TRIGGER ins_sum
BEFORE INSERT
ON public.monitors
FOR EACH ROW
EXECUTE FUNCTION ins_sum();

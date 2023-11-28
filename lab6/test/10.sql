CREATE OR REPLACE FUNCTION before_update_value_trigger()
RETURNS TRIGGER AS $$
BEGIN
    NEW.monitor_price := NEW.monitor_price * 1.1; -- Увеличиваем значение на 10%
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_update_value
BEFORE UPDATE ON public.monitors
FOR EACH ROW
EXECUTE FUNCTION before_update_value_trigger();

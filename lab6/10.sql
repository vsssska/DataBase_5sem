CREATE OR REPLACE FUNCTION before_update_value_trigger()
RETURNS TRIGGER AS $$
BEGIN
    NEW.order_price := NEW.order_price * 1.1; -- Увеличиваем значение на 10%
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_update_value
BEFORE UPDATE ON public.orders
FOR EACH ROW
EXECUTE FUNCTION before_update_value_trigger();

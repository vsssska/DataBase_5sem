CREATE OR REPLACE FUNCTION ins_sum()
RETURNS TRIGGER AS $$
BEGIN
    -- Использую COALESCE, чтобы обработать NULL значения
    NEW.order_price := COALESCE(NEW.order_price, 0);

    UPDATE orders
    SET order_price = order_price + NEW.order_price;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Создайте триггер, который будет активироваться перед каждой вставкой в таблицу orders
CREATE TRIGGER ins_sum
BEFORE INSERT
ON public.orders
FOR EACH ROW
EXECUTE FUNCTION ins_sum();

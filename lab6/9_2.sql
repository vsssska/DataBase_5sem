-- Вставка данных в таблицу orders
INSERT INTO public.orders (boat_id, order_price)
VALUES
(8, 900.00),
(2, 1200.00),
(1, 700.00);
--Просмотр результато
SELECT * FROM public.orders;
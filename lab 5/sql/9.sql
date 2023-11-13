CREATE OR REPLACE VIEW bill_modifiable AS
SELECT *
FROM public.bill
WITH CHECK OPTION;

-- Вставка новой записи в таблицу bill через представление
INSERT INTO bill_modifiable (date, price, use_time)
VALUES ('2023-11-13', 1500, 5);

-- Обновление существующей записи в таблице bill через представление
UPDATE bill_modifiable
SET price = 1500
WHERE bill_modifiable."bill_ID" = 1;

-- Удаление записи из таблицы bill через представление
DELETE FROM bill_modifiable
WHERE bill_modifiable."bill_ID" = 2;

SELECT * 
FROM bill_modifiable;
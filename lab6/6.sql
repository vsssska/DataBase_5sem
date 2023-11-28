CREATE OR REPLACE PROCEDURE Itog(IN parent_object_type VARCHAR(255))
LANGUAGE plpgsql
AS $$
DECLARE
    object_count INT;
	rating VARCHAR(255);
BEGIN
    -- Подсчитываем количество арендованных лодок данного типа из дочерней таблицы
    SELECT
        COUNT(*)
    INTO
        object_count
    FROM
        public.orders c
    JOIN
        public.boats p ON c.boat_id = p.boat_id
    WHERE
        p.boat_type = parent_object_type;

    -- Выводим наименование объекта в зависимости от суммарного количества
    IF object_count < 2 THEN
        rating = 'Незначительный объект';
    ELSIF object_count > 2 AND object_count <= 3 THEN
        rating = 'Оценка: Обычный объект';
    ELSE
        rating = 'Оценка: Значительный объект';
    END IF;
	RAISE NOTICE 'Тип: % Кол-во: % Оценка: %', parent_object_type, object_count, rating;
END;
$$;

CALL Itog('Катамаран');

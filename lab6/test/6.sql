CREATE OR REPLACE PROCEDURE Itog(IN brand_name VARCHAR)
LANGUAGE plpgsql
AS $$
DECLARE
    total_count INTEGER;
    rating VARCHAR;
BEGIN
    -- Подсчитываем общее количество объектов по заданному бренду
    SELECT COUNT(*)
    INTO total_count
    FROM public.monitors
    WHERE monitor_brand = brand_name;

    -- Присваиваем оценку в зависимости от общего количества объектов
    IF total_count < 2 THEN
        rating := 'Незначительный объект';
    ELSIF total_count <= 3 THEN
        rating := 'Обычный объект';
    ELSE
        rating := 'Значительный объект';
    END IF;

    -- Выводим результат
    RAISE NOTICE 'Бренд: %, Общее количество объектов: %, Оценка: %', brand_name, total_count, rating;
END;
$$;
CALL Itog('Эйсер');

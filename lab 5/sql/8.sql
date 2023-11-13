UPDATE public.bill
SET price = 0
WHERE price IS NULL;

SELECT *
FROM Itog_query;
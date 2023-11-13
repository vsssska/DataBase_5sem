CREATE OR REPLACE VIEW Itog_query AS
SELECT
    date AS "Дата проката",
    boat_type AS "Тип транспорта",
    use_time AS "Срок проката",
    price AS "Стоимость, руб.",
    seller_name AS "Продавец",
    second_name AS "Покупатель",
    gender AS "Пол покупателя",
    age AS "Возраст покупателя"
FROM public.bill
JOIN public.buyer ON bill."buyer_ID" = buyer."buyer_ID"
JOIN public.seller ON bill."seller_ID" = seller."seller_ID"
JOIN public.boat ON bill."boat_ID" = boat."boat_ID";

SELECT *
FROM Itog_query;
SELECT s."buyer_ID" AS id, s.second_name AS name, 'Мониторы - CОВПАДАЕТ' AS description
FROM public.buyer AS s
WHERE s."buyer_ID" IN (SELECT "buyer_ID" FROM public.bill)
UNION
SELECT s."buyer_ID" AS id, s.second_name AS name, 'Мониторы - НЕ СОВПАДАЕТ' AS description
FROM public.buyer AS s
WHERE s."buyer_ID" NOT IN (SELECT "buyer_ID" FROM public.bill)
UNION
SELECT v."seller_ID" AS id, v.seller_name AS name, 'Поставщики - СОВПАДАЕТ' AS description
FROM public.seller AS v
WHERE v."seller_ID" IN (SELECT "seller_ID" FROM public.bill)
UNION
SELECT v."seller_ID" AS id, v.seller_name AS name, 'Поставщики - НЕ СОВПАДАЕТ' AS description
FROM public.seller AS v
WHERE v."seller_ID" NOT IN (SELECT "seller_ID" FROM public.bill)
ORDER BY name DESC;
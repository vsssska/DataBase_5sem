SELECT
    obj_name,
    age,
    CASE
        WHEN age > avg_age THEN 'Выше среднего'
        WHEN age < avg_age THEN 'Ниже среднего'
    END AS text_param
FROM (
    SELECT
        m.second_name AS obj_name,
        m.age AS age
    FROM public.buyer AS m
    WHERE m.age IS NOT NULL

    UNION

    SELECT
        v.seller_name AS obj_name,
        LENGTH(v.seller_name) AS age
    FROM public.seller AS v
    WHERE LENGTH(v.seller_name) IS NOT NULL
) AS combined_data
CROSS JOIN (
    SELECT AVG(age) AS avg_age
    FROM (
        SELECT age AS age FROM public.buyer WHERE age IS NOT NULL
        UNION ALL
        SELECT LENGTH(seller_name) AS age FROM public.seller WHERE LENGTH(seller_name) IS NOT NULL
    ) AS all_params
) AS avg_data
ORDER BY obj_name;

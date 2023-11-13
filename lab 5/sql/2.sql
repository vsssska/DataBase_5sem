WITH CombinedData AS (
    SELECT
        obj_name,
        age,
        CASE
            WHEN age = max_age THEN 'Наивысший'
            WHEN age = min_age THEN 'Низший'
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
        SELECT
            MAX(age) AS max_age,
            MIN(age) AS min_age
        FROM (
            SELECT age AS age FROM public.buyer WHERE age IS NOT NULL
            UNION ALL
            SELECT LENGTH(seller_name) AS age FROM public.seller WHERE LENGTH(seller_name) IS NOT NULL
        ) AS all_params
    ) AS summary_data
)

SELECT obj_name, age, text_param
FROM CombinedData
WHERE age IS NOT NULL
ORDER BY obj_name DESC;

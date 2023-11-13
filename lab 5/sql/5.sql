SELECT buyer."buyer_ID", buyer."gender", buyer."age"
FROM public.buyer
WHERE buyer."age" > 20

EXCEPT

SELECT buyer."buyer_ID", buyer."gender", buyer."age"
FROM public.buyer
WHERE buyer."gender" = 'женский';

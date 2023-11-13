SELECT buyer."buyer_ID", buyer."gender", buyer."age"
FROM public.buyer
WHERE buyer."age" > 24

INTERSECT

SELECT buyer."buyer_ID", buyer."gender", buyer."age"
FROM public.buyer
WHERE buyer."gender" = 'женский'	;

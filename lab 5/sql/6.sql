CREATE OR REPLACE VIEW restricted_buyer AS
SELECT buyer."buyer_ID", buyer."gender", buyer."age"
FROM public.buyer
WHERE buyer."gender" = 'женский'
WITH CHECK OPTION;

SELECT *
FROM restricted_buyer;
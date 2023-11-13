CREATE OR REPLACE VIEW Avg_Sum AS
SELECT
  m.gender,
  AVG(o.price) AS avg_price
FROM
  public.buyer m
  JOIN public.bill o ON m."buyer_ID" = o."buyer_ID"
GROUP BY m.gender;

SELECT *
FROM Avg_Sum;
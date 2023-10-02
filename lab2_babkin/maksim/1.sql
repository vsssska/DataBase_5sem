SELECT *
FROM vendors 
INNER JOIN sex
ON sex.sex_id = vendors.sex_id;

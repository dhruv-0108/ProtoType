SELECT function_desc, equip_desc, SUM(duration_mins) AS TotalDowntime
FROM MAIN_DATA
GROUP BY function_desc, equip_desc WITH ROLLUP
HAVING (function_desc IS NOT NULL AND equip_desc IS NOT NULL) OR (function_desc IS NOT NULL AND equip_desc IS NULL);


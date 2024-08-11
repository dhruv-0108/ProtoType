select SUM(duration_mins) as downtime,function_desc
from MAIN_DATA
group by function_desc
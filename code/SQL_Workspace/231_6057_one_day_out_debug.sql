DECLARE
  P_QUERY VARCHAR2(2000);
  P_CONDITION VARCHAR2(200);
  P_FILENAME_PRE VARCHAR2(200);
BEGIN
--  P_QUERY := 'select * from
--(select to_char(btsj, ''yyyy-mm-dd'') as btsj
--from itf_6a
--where 1=1
--and t_type_id = 231
--and loco_no = 6057
--group by to_char(btsj, ''yyyy-mm-dd'')
--order by btsj asc)
--where rownum <5';

--P_QUERY := 'select btsj
--from
--(
--select to_char(btsj, ''yyyy-mm-dd'') as btsj, count(*) num
--from itf_6a
--where 1=1
--and t_type_id = 231
--and loco_no = 6057
--group by to_char(btsj, ''yyyy-mm-dd'')
--order by num desc
--)
--where rownum <5';

P_QUERY := 'select * from
(select to_char(btsj, ''yyyy-mm-dd'') as btsj
from itf_6a
where 1=1
and t_type_id = 231
and loco_no = 6057
group by to_char(btsj, ''yyyy-mm-dd'')
order by btsj asc)
where btsj not in
(
  select to_char(gzkssj, ''yyyy-mm-dd'') as gzkssj
  from itf_6afault_start
  where 1=1
  and gzdm not in (4264229,4264228)
  and t_type_id = 231
  and loco_no = 6057
  group by to_char(gzkssj, ''yyyy-mm-dd'')
)';

  P_CONDITION := '
and t_type_id = 231 
and loco_no = 6057';
  P_FILENAME_PRE := '231-6057';

  OUT_1_DAY_DATA_PRO(
    P_QUERY => P_QUERY,
    P_CONDITION => P_CONDITION,
    P_FILENAME_PRE => P_FILENAME_PRE
  );
--rollback; 
END;

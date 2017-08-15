DECLARE
  P_QUERY VARCHAR2(500);
  P_CONDITION VARCHAR2(200);
  P_FILENAME_PRE VARCHAR2(200);
BEGIN
  P_QUERY := 'select to_char(gzkssj, ''yyyy-mm-dd'') as gzkssj, count(to_char(gzkssj, ''yyyy-mm-dd'')) as num from ITF_TCMSFAULT_START 
 where 1=1
 and t_type_id = 240
 and loco_no = 142
 and gzdm = 1423
 group by to_char(gzkssj, ''yyyy-mm-dd'')
order by gzkssj asc';
  
  --and loco_no = 413

  P_CONDITION := 
  ' and t_type_id = 240
    and loco_no = 142';
  
  --P_FILENAME_PRE := '240-445-1423';
  P_FILENAME_PRE := '240-413-1423';

  OUT_1_DAY_DATA_PRO(
    P_QUERY => P_QUERY,
    P_CONDITION => P_CONDITION,
    P_FILENAME_PRE => P_FILENAME_PRE
  );
END;

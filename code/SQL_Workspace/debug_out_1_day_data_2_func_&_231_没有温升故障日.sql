DECLARE
  P_QUERY VARCHAR2(2000);
  P_TABLENAME VARCHAR2(200);
  P_CONDITION VARCHAR2(200);
  P_FILENAME_PRE VARCHAR2(200);
  v_Return VARCHAR2(200);
BEGIN
  P_QUERY := 
  'select btsj, loco_no
from 
(
  select to_char(btsj, ''yyyy-mm-dd'') as btsj, loco_no, count(*) as num
  from itf_6a
  where 1=1
  and t_type_id=231
  group by to_char(btsj, ''yyyy-mm-dd''), loco_no
  order by num desc  
)
where 1=1
and rownum<11';
  P_TABLENAME := ' itf_6a ';
  P_CONDITION := ' and t_type_id = 231 ';
  P_FILENAME_PRE := '231';

  v_Return := OUT_1_DAY_DATA_2_FUNC(
    P_QUERY => P_QUERY,
    P_TABLENAME => P_TABLENAME,
    P_CONDITION => P_CONDITION,
    P_FILENAME_PRE => P_FILENAME_PRE
  );
  /* Legacy output: 
DBMS_OUTPUT.PUT_LINE('v_Return = ' || v_Return);
*/ 
  :v_Return := v_Return;
--rollback; 
END;

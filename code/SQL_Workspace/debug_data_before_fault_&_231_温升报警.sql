DECLARE
  P_QUERY VARCHAR2(2000);
  P_TABLENAME VARCHAR2(200);
  P_CONDITION VARCHAR2(200);
  P_FILENAME_PRE VARCHAR2(200);
  v_Return VARCHAR2(200);
BEGIN
  P_QUERY := 'select gzkssj, loco_no 
from itf_6afault_start
where 1=1
and gzdm = (
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like ''%Öá%ÎÂ%''
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1 )
and t_type_id = 231
order by gzkssj asc';
  P_TABLENAME := 'itf_6a';
  P_CONDITION := ' and t_type_id = 231 ';
  P_FILENAME_PRE := '231';

  v_Return := DATA_BEFORE_FAULT_FUNCTION(
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

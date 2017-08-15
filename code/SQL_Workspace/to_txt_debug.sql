DECLARE
  P_QUERY VARCHAR2(2000);
  P_DIR VARCHAR2(200);
  P_FILENAME VARCHAR2(200);
BEGIN
  P_QUERY := 'select yx_ybdy, yx_ybdl from itf_tcms_hxd_v20
where 1=1 
and t_type_id = 240     
and loco_no = 142 
and btsj between to_date(''2016-04-15'', ''yyyy-mm-dd'')+1/24/60/60 and to_date(''2016-04-15'', ''yyyy-mm-dd'')+1-1/24/60/60 order by btsj asc';
  P_DIR := 'MYDIR';
  P_FILENAME := '240-142-1423_2016-04-15.txt';

  TO_TXT_PROCEDURE(
    P_QUERY => P_QUERY,
    P_DIR => P_DIR,
    P_FILENAME => P_FILENAME
  );



END;

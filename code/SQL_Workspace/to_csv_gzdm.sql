DECLARE
  P_QUERY VARCHAR2(2000);
  P_DIR VARCHAR2(200);
  P_FILENAME VARCHAR2(200);
BEGIN
  P_QUERY := 'select r2.num, r2.t_type_id, r2.loco_no, r1.gzdm, r1.gzmc, r1.gzms from gzdm_type r1,
(
select t1.gzdm, t1.t_type_id, t1.loco_no, count(*) num
from itf_tcmsfault_start t1, gzdm_type t2
where t1.gzdm = t2.gzdm
group by t1.gzdm, t1.t_type_id, t1.loco_no
) r2
where r1.gzdm = r2.gzdm
order by r2.num desc, r2.t_type_id desc';
  P_DIR := 'MYDIR';
  P_FILENAME := 'gzdm_b_info.csv';

  TO_CSV_PROCEDURE(
    P_QUERY => P_QUERY,
    P_DIR => P_DIR,
    P_FILENAME => P_FILENAME
  );
--rollback; 
END;

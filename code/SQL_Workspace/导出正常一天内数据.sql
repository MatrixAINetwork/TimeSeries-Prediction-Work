DECLARE
  P_QUERY VARCHAR2(200);
  t1 VARCHAR2(200);
  t2 VARCHAR2(200);
BEGIN

--  t1 := '2016-04-09';
--  t2 := '2016-04-10';

--  t1 := '2016-04-19';
--  t2 := '2016-04-20';
  
--  t1 := '2016-04-13';
--  t2 := '2016-04-14';

--  t1 := '2016-04-11';
--  t2 := '2016-04-12';
  
--  t1 := '2016-04-12';
--  t2 := '2016-04-13';
  
  t1 := '2016-04-15';
  t2 := '2016-04-16';
  
  P_QUERY := 
'select BTSJ, YX_YBDY, YX_YBDL
from ITF_TCMS_HXD_V20
where 1=1
and t_type_id = 240
and loco_no = 142
and btsj between '''|| t1 ||''' and ''' || t2 || ''' 
order by btsj asc';

  to_csv_procedure(P_QUERY, 'MYDIR',  '240-142-1423-Apr-15.csv');
END;

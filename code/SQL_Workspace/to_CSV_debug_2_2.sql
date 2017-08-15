DECLARE
  P_QUERY VARCHAR2(200);
  P_DIR VARCHAR2(200);
  P_FILENAME_PRE VARCHAR2(200);
BEGIN
  P_QUERY := ' select * from itf_6a where t_type_id = 231 and loco_no = 6107 and rownum <= 10';
  P_DIR := 'MYDIR';
  P_FILENAME_PRE := '231-6107-20160401';

  TO_CSV_PROCEDURE_2(
    P_QUERY => P_QUERY,
    P_DIR => P_DIR,
    P_FILENAME_PRE => P_FILENAME_PRE
  );
END;

DECLARE
  P_QUERY VARCHAR2(200);
  P_DIR VARCHAR2(200);
  P_FILENAME VARCHAR2(200);
BEGIN
  P_QUERY := 'select * from itf_6a where rownum <= 10';
  P_DIR := 'MYDIR';
  P_FILENAME := 'example.csv';

  TO_CSV_PROCEDURE(
    P_QUERY => P_QUERY,
    P_DIR => P_DIR,
    P_FILENAME => P_FILENAME
  );
END;

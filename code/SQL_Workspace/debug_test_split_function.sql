DECLARE
  P_LIST VARCHAR2(200);
  P_SEP VARCHAR2(200);
  v_Return BJCMD.TYPE_SPLIT;
BEGIN
  P_LIST := '2015-10-11 22:12:00';
  P_SEP := ' ';

  v_Return := SPLIT_FUNCTION(
    P_LIST => P_LIST,
    P_SEP => P_SEP
  );
  /* Legacy output: 
DBMS_OUTPUT.PUT_LINE('v_Return = ' || v_Return);
*/ 
  --:v_Return := v_Return;
--rollback; 
END;

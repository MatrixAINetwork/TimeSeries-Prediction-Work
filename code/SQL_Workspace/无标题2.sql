 create or replace directory MYDIR as'c:\';
 
 select * from itf_6a where rownum <= 10
 
declare
  fhandleutl_file.file_type;
begin
  sql_to_csv('select * from itf_6a where rownum <= 10','MYDIR','example.csv');
end;
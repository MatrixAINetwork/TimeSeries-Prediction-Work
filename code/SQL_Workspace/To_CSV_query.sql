/*创建目录*/
create or replace directory MYDIR as'o:\output\';
/*查看目录*/
desc dba_directories
select * from dba_directories;
/**/
 
 /*test query*/
 select * from itf_6a where rownum <= 10
 select * from itf_6a where t_type_id = 231 and loco_no = 6107 and rownum <= 10
 
/* (1)用户UserName授权*/
grant execute on Proc to UserName;

/*动态导出*/


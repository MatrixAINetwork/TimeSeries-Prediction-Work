DECLARE
  P_QUERY VARCHAR2(2000);
  P_CONDITION VARCHAR2(200);
  P_FILENAME_PRE VARCHAR2(200);
BEGIN
  P_QUERY := 
  'select *
from 
(
  --筛选没有故障的时间
  select to_char(btsj, ''yyyy-mm-dd'') as btsj
  from itf_6a
  where 1=1
  and t_type_id=231
  and to_char(btsj, ''yyyy-mm-dd'') not in
  (
    --有故障的时间
    select to_char(gzkssj, ''yyyy-mm-dd'') as gzkssj
    from itf_6afault_start
    where 1=1
    and gzdm = (
      select gzdm
      from (
        select gzdm, gzmc, count(*) num 
        from itf_6afault_start
        where gzmc like ''%轴%温%''
        group by gzdm, gzmc
        order by num desc
      ) t1
      where rownum = 1 )
    and t_type_id = 231
    group by to_char(gzkssj,''yyyy-mm-dd'')
  )
  group by to_char(btsj, ''yyyy-mm-dd'')
  order by btsj desc
)
where 1=1
and rownum<11';
  P_CONDITION := 
  ' and t_type_id = 231 ';
  P_FILENAME_PRE := '231';

  OUT_1_DAY_DATA_PRO(
    P_QUERY => P_QUERY,
    P_CONDITION => P_CONDITION,
    P_FILENAME_PRE => P_FILENAME_PRE
  );
--rollback; 
END;

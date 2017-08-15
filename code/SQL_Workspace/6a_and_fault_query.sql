--不同时间【】-- 查询轴温故障
select * from itf_6afault_start
where gzmc like '%轴%温%'

--统计有温升故障的车型
select t_type_id, count(*) as num
from itf_6afault_start
where gzmc like '%轴%温%'
group by t_type_id
order by num desc
--统计有温升故障的车型+车号
select t_type_id, loco_no, count(*) as num
from itf_6afault_start
where gzmc like '%轴%温%'
group by t_type_id, loco_no
order by t_type_id

--统计轴温故障类型
select gzdm, gzmc, count(*) num 
from itf_6afault_start
where gzmc like '%轴%温%'
group by gzdm, gzmc
order by num desc
--根据结果发现2轴5位温升报警最多
--筛选出所有2轴报警的GZDM
select gzdm, gzmc, count(*) num 
from itf_6afault_start
where gzmc like '%2轴%温%'
group by gzdm, gzmc
order by num desc

--获得最多故障的gzdm
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1

--查询最多次轴温故障
select * 
from itf_6afault_start
where gzdm = 
(
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1
)

--统计最多轴温故障车号
select t_type_id, loco_no, gzdm,count(*) num 
from itf_6afault_start
where gzdm = 
(
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1
)
group by t_type_id, loco_no, gzdm
order by num desc

--统计最多次轴温故障时间
select t_type_id, loco_no,to_char(gzkssj, 'yyyy-mm-dd') as gzkssj
from itf_6afault_start
where gzdm = 
(
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1
)
group by t_type_id, loco_no, to_char(gzkssj, 'yyyy-mm-dd')

--查询最多次轴温故障开始时间
select t_type_id, loco_no, gzkssj
from itf_6afault_start
where gzdm = 
(
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1
)
order by t_type_id asc, loco_no asc, gzkssj asc

--统计最多故障231车型不同车号
select loco_no, count(*) num
from itf_6afault_start
where gzdm = 
(
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1
)
and t_type_id = 231
group by loco_no
order by num desc
--6057

select loco_no,gzdm, gzmc, gzkssj
from itf_6afault_start
where 1=1
and t_type_id = 162
and loco_no in (70,87)
order by loco_no, gzkssj

select to_char(gzkssj, 'yyyy-mm-dd') gzkssj, count(*) as num
from itf_6afault_start
where 1=1
and t_type_id = 162
and loco_no = 70
group by to_char(gzkssj, 'yyyy-mm-dd')
--2016-04-13	1
--2016-04-08	7

select to_char(gzkssj, 'yyyy-mm-dd') gzkssj, count(*) as num
from itf_6afault_start
where 1=1
and t_type_id = 162
and loco_no = 87
group by to_char(gzkssj, 'yyyy-mm-dd')
--2016-04-25	6


select *
from itf_6a
where 1=1
and t_type_id = 162
and loco_no = 70
and btsj between to_date('2016/04/13', 'yyyy-mm-dd') and to_date('2016/04/13', 'yyyy-mm-dd')+1-1/24/60/60
order by btsj asc

select t_type_id, loco_no,to_char(gzkssj,'yyyy-mm-dd') as gzkssj, count(*) num 
from itf_6afault_start
where gzmc like '%轴%温%'
group by t_type_id, loco_no, to_char(gzkssj,'yyyy-mm-dd')
order by num desc

--各车的轴温故障名称
select t_type_id, loco_no, gzdm, gzmc, gzkssj
from itf_6afault_start
where gzmc like '%轴%温%'
order by t_type_id, loco_no, gzdm, gzmc

--最多温升故障的详细信息
select * 
from itf_6afault_start
where 1=1
and gzdm = (
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1 )
--231车最多纪录
--筛选故障时间
select to_char(gzkssj, 'yyyy-mm-dd') as gzkssj, count(*) as num 
from itf_6afault_start
where 1=1
and gzdm = (
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1 )
and t_type_id = 231
group by to_char(gzkssj,'yyyy-mm-dd')
order by gzkssj asc

--
select gzkssj, loco_no 
from itf_6afault_start
where 1=1
and gzdm = (
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1 )
and t_type_id = 231
order by gzkssj asc

--【Debug】----------------------------------------------------
--Out_1_day_data_pro
---------------------------------------------------------------
--231车型-没有报故障的时间
--取前5个没有故障的时间
select *
from 
(
  --筛选没有故障的时间
  select to_char(btsj, 'yyyy-mm-dd') as btsj
  from itf_6a
  where 1=1
  and t_type_id=231
  and to_char(btsj, 'yyyy-mm-dd') not in
  (
    --有故障的时间
    select to_char(gzkssj, 'yyyy-mm-dd') as gzkssj
    from itf_6afault_start
    where 1=1
    and gzdm = (
      select gzdm
      from (
        select gzdm, gzmc, count(*) num 
        from itf_6afault_start
        where gzmc like '%轴%温%'
        group by gzdm, gzmc
        order by num desc
      ) t1
      where rownum = 1 )
    and t_type_id = 231
    group by to_char(gzkssj,'yyyy-mm-dd')
  )
  group by to_char(btsj, 'yyyy-mm-dd')
  order by btsj desc
)
where 1=1
and rownum<11
----------------------------------------------------------------
--231车型-没有报故障的时间
--取前10个没有故障的时间
select btsj, loco_no
from 
(
  select to_char(btsj, 'yyyy-mm-dd') as btsj, loco_no
  from itf_6a
  where 1=1
  and t_type_id=231
  group by to_char(btsj, 'yyyy-mm-dd'), loco_no
  order by btsj desc  
)
where 1=1
and rownum<11
----------------------------
and btsj not in
(
    --有故障的时间
    select to_char(gzkssj, 'yyyy-mm-dd') as gzkssj
    from itf_6afault_start
    where 1=1
    and gzdm = (
      select gzdm
      from (
        select gzdm, gzmc, count(*) num 
        from itf_6afault_start
        where gzmc like '%轴%温%'
        group by gzdm, gzmc
        order by num desc
      ) t1
      where rownum = 1 )
    and t_type_id = 231
    group by to_char(gzkssj,'yyyy-mm-dd')
)

--车型、车号、时间分组
select *
from 
(
  select t_type_id, loco_no, to_char(btsj, 'yyyy-mm-dd') as btsj, count(*) as num
  from itf_6a
  where 1=1
  group by t_type_id, loco_no, to_char(btsj, 'yyyy-mm-dd')
  order by num desc
)
where 1=1
and rownum < 100

select *
from itf_6a
where 1=1
and 
  

--[itf_6a]--------------------------------------------
select * from
(select to_char(btsj, 'yyyy-mm-dd') as btsj
from itf_6a
where 1=1
and t_type_id = 231
and loco_no = 6057
group by to_char(btsj, 'yyyy-mm-dd')
order by btsj asc)
where btsj not in
(
  select to_char(gzkssj, 'yyyy-mm-dd') as gzkssj
  from itf_6afault_start
  where 1=1
  and gzdm not in (4264229,4264228)
  and t_type_id = 231
  and loco_no = 6057
  group by to_char(gzkssj, 'yyyy-mm-dd')
)
--where rownum <5

declare 
m_query varchar(1000);
m_dir varchar(100);
m_filename varchar(50);

m_cursor INTEGER DEFAULT DBMS_SQL.OPEN_CURSOR;
m_status integer;
m_gzkssj varchar(100);
m_t_type_id varchar(100);
m_loco_no varchar(100);
m_columnum integer := 0;
m_desctab dbms_sql.desc_tab;
begin
  m_query := 'select t_type_id, loco_no,to_char(gzkssj, ''yyyy-mm-dd'') as gzkssj
from itf_6afault_start
where gzdm = 
(
  select gzdm
  from (
    select gzdm, gzmc, count(*) num 
    from itf_6afault_start
    where gzmc like ''%轴%温%''
    group by gzdm, gzmc
    order by num desc
  ) t1
  where rownum = 1
)
group by t_type_id, loco_no, to_char(gzkssj, ''yyyy-mm-dd'')';  
  
  dbms_sql.parse(m_cursor, m_query, dbms_sql.native);
  dbms_sql.describe_columns(m_cursor, m_columnum, m_desctab);
  dbms_sql.define_column(m_cursor, 1, m_t_type_id, 100); 
  dbms_sql.define_column(m_cursor, 2, m_loco_no, 100); 
  dbms_sql.define_column(m_cursor, 3, m_gzkssj, 100);    
  
  --get gzdm related
  t_cursor INTEGER DEFAULT DBMS_SQL.OPEN_CURSOR;
  t_columnum integer :=0;
  t_gzdm varchar(100);
  t_desctab dbms_sql.desc_tab;
  
  m_query := '';
  while(dbms_sql.fetch_rows(m_cursor) > 0) loop
    dbms_sql.column_value(m_cursor, 1, m_t_type_id);
    dbms_sql.column_value(m_cursor, 2, m_loco_no);
    dbms_sql.column_value(m_cursor, 3, m_gzkssj);
    
    m_filename = m_type_id || '_' || loco_no || '_' ;    
  end loop;
  
end;

--[itf_6a & itf_6afault_start]------------------------


select * 
from itf_6a
where 1=1
and t_type_id = 162
and loco_no = 70
order by btsj desc

--[1]
--在6a中，报轴温错误的车型策、车号、时间
select t_type_id, loco_no, to_char(btsj, 'yyyy-mm-dd') as btsj, count(*) as num
from itf_6a
where 1=1
and btsj in 
(
  select btsj 
  from
  (
    select t_type_id, loco_no,to_char(gzkssj,'yyyy-mm-dd') as gzkssj
    from itf_6afault_start
    where gzmc like '%轴%温%'
    group by t_type_id, loco_no, to_char(gzkssj,'yyyy-mm-dd')
  )
)
group by t_type_id, loco_no, to_char(btsj, 'yyyy-mm-dd')
order by num desc

----------------------------------
--[1]
--不同车型、车号，报轴温错误的时间点
select t_type_id, loco_no,gzkssj
from itf_6afault_start
where gzmc like '%轴%温%'
order by gzkssj 
--[1.1]
--查看231-6075报的故障轴温故障   
select *
from itf_6afault_start
where 1=1
and t_type_id=231
and loco_no=6075
and gzmc like '%轴%温%'
--[1.2]
--检查162型-0070号故障数据
select *
from itf_6afault_start
where 1=1
and t_type_id=162
and loco_no=0070
and gzmc like '%轴%温%'
----------------------------------
--[2]
--不同车型、车号，报轴温错误的时间点+故障名称
select t_type_id, loco_no, gzkssj,gzmc
from itf_6afault_start
where gzmc like '%轴%温%'
order by t_type_id, loco_no, gzkssj


    
    
    

select count(*) from ITF_6A 
--24244,5792

/*231型-全部数据*/
select * from ITF_6A 
where t_type_id = 231
order by t_type_id

/*231车1124号-排序后全部数据*/
select * from ITF_6A 
where loco_no = 1124
order by loco_no, btsj asc

/*231型-不同车号数据统计：*/
select loco_no, count(*) from ITF_6A 
where t_type_id = 231
group by loco_no
order by loco_no

/*231型-故障数据：*/
select * from ITF_6A 
where t_type_id = 231
and loco_no in (1124,1247,1256,1121,1150,1305,1333,1309,1436,1265,19,177,53,34,248,177)
order by loco_no

select t_type_id, count(*) from ITF_6A 
where loco_no in (1124,1247,1256,1121,1150,1305,1333,1309,1436,1265,19,177,53,34,248,177)
group by t_type_id


/*不同车型数据总数*/
/*
162	981896
160	1856537
232	2703928
238	3983810
163	4719894
233	20710717
231	30990918
242	32889343
240	39664820
237	47555209
239	56388720
*/
select t_type_id, count(*) as num from ITF_6A
group by t_type_id
order by num

select * from ITF_6A where t_type_id = 239

select * from ITF_6A where t_type_id = 231

select count(*) from ITF_6A where t_type_id = 231

select t_type_id, loco_no, count(*) as num
from
(
  select t_type_id, loco_no, to_char(btsj,'yyyy-mm-dd') as bjts, count(*) as num
  from itf_6a
  group by t_type_id, loco_no, to_char(btsj,'yyyy-mm-dd')
) tmp
where tmp.num > 5000 
group by t_type_id, loco_no
order by num desc

select to_char(btsj,'yyyy-mm-dd') as btsj, count(*) as num
from itf_6a
where t_type_id = 231 
and loco_no = 6097
and btsj not in
(
  select to_char(btsj,'yyyy-mm-dd') as btsj
  from itf_6afault_start
  where gzmc like '%轴%温%'
  and t_type_id = 231
  and loco_no = 6097
  group by to_char(btsj,'yyyy-mm-dd')
)
group by to_char(btsj,'yyyy-mm-dd')
order by num desc

select btsj
from 
(
  select to_char(btsj,'yyyy-mm-dd') as btsj, count(*) as num
  from itf_6a
  where t_type_id = 231 
  and loco_no = 6097
  and btsj not in
  (
    select to_char(btsj,'yyyy-mm-dd') as btsj
    from itf_6afault_start
    where gzmc like '%轴%温%'
    and t_type_id = 231
    and loco_no = 6097
    group by to_char(btsj,'yyyy-mm-dd')
  )
  group by to_char(btsj,'yyyy-mm-dd')
  order by num desc  
)





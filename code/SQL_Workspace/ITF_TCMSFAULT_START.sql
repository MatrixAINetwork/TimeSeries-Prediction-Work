/*231型-故障数据：*/
select * from ITF_TCMSFAULT_START 
where t_type_id = 231
and loco_no in (1124,1247,1256,1121,1150,1305,1333,1309,1436,1265,19,177,53,34,248,177)
order by loco_no

select t_type_id, count(*) from ITF_TCMSFAULT_START 
where loco_no in (1124,1247,1256,1121,1150,1305,1333,1309,1436,1265,19,177,53,34,248,177)
group by t_type_id

/*231型-分类故障代码*/
select gzdm, count(*) as num from ITF_TCMSFAULT_START 
where t_type_id = 231
group by gzdm
order by num desc

/*获得不同车型的记录数目*/
select t_type_id, count(*) as num from ITF_TCMSFAULT_START
group by t_type_id
order by num
/*
232	9697
160	52747
163	56868
239	154572
231	173984
242	604757
240	1258358
237	1264614
*/

--240车型不同车号故障数据查询
select * from ITF_TCMSFAULT_START 
where 1=1
and t_type_id = 240
and loco_no = 142
--and loco_no = 413
--and loco_no = 445
and gzdm in (1423,1424) 
--and gzdm = 1423
--and gzdm = 1424

--240车型142车号1423故障时间按照日期分组
select to_char(gzkssj, 'yyyy-mm-dd') as gzkssj, count(to_char(gzkssj, 'yyyy-mm-dd')) as num from ITF_TCMSFAULT_START 
where 1=1
and t_type_id = 240
and loco_no = 142
and gzdm = 1423
group by to_char(gzkssj, 'yyyy-mm-dd')
order by gzkssj asc

--240车型142车号1423故障开始时间
select gzkssj from ITF_TCMSFAULT_START 
where 1=1
and t_type_id = 240
and loco_no = 142
and gzdm = 1423

select loco_no,gzkssj from ITF_TCMSFAULT_START 
where 1=1
and t_type_id = 240
and loco_no in (142, 413, 445)
and gzdm = 1423
order by loco_no asc, gzkssj asc



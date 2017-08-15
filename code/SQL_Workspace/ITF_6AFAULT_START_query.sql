/*分类故障代码数目*/
select gzdm, count(*) from ITF_6AFAULT_START 
group by gzdm

/*231型-分类故障代码*/
select gzdm, count(*) as num from ITF_6AFAULT_START 
where t_type_id = 231
group by gzdm
order by num desc

/*231型-故障数据：*/
select * from ITF_6AFAULT_START 
where t_type_id = 231
and loco_no in (1124,1247,1256,1121,1150,1305,1333,1309,1436,1265,19,177,53,34,248,177)
order by loco_no

select t_type_id, count(*) 
from ITF_6AFAULT_START 
where loco_no in (1124,1247,1256,1121,1150,1305,1333,1309,1436,1265,19,177,53,34,248,177)
group by t_type_id

select , count(*) 
from ITF_6AFAULT_START 
where loco_no in (1124,1247,1256,1121,1150,1305,1333,1309,1436,1265,19,177,53,34,248,177)
group by t_type_id


/*获得每个车型的记录数目*/
select t_type_id, count(*) as num from itf_6afault_start
group by t_type_id
order by num
/*
163	60
232	94
238	335
162	430
231	826
160	1012
233	1183
240	2185
242	3798
239	4299
237	12252
*/
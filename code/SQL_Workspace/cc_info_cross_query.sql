--itf_tcmsfault_start & itf_3g_header
select count(*)
from
(select lineno, t_type_id, loco_no, count(*) as num
from itf_3g_header
group by lineno, t_type_id, loco_no
order by num desc) r1,
(select cc, t_type_id, loco_no, count(*) as num
from itf_tcmsfault_start
group by cc, t_type_id, loco_no
order by num desc) r2
where 1=1
and r1.t_type_id = r2.t_type_id
and r1.loco_no = r2.loco_no
and r1.lineno = r2.cc


--itf_tcms_hxd_v20 & itf_3g_header
select r2.lineno, r1.t_type_id, r1.loco_no, r1.num as v20_num, r2.num as g_num
from 
(select t_type_id, loco_no, count(*) as num
from itf_tcms_hxd_v20
group by t_type_id, loco_no) r1, 
(select t_type_id, loco_no, lineno, count(*) as num
from itf_3g_header
group by t_type_id, loco_no, lineno) r2
where 1=1
and r1.t_type_id = r2.t_type_id 
and r1.loco_no = r2.loco_no
order by r1.t_type_id, r1.loco_no, r2.lineno

--itf_tcms_hxd_v20: 同车型，车号数据统计
--select * 
--select min(btsj), max(btsj)
select btsj
from itf_tcms_hxd_v20
where 1=1
and t_type_id = 231
and loco_no = 1441
--限制在5月20日
--and btsj >= '19-5月-16'
and btsj >= '20-5月 -16'
order by btsj
--1441: 31-3月 -16 23:59:55	20-5月 -16 15:41:13
--1442: 20-5月 -16 03:45:40	20-5月 -16 15:41:55
--1443: 20-5月 -16 00:00:14	20-5月 -16 15:41:55

--itf_3g_header: 同车型，车号数据统计
--select * 
select min(btsj+5/24/60), max(btsj)
--select btsj
from itf_3g_header
where 1=1
and t_type_id = 231
and loco_no = 1442
and lineno = 56
order by btsj 
--1441: 20-5月 -16 00:00:21	20-5月 -16 15:58:03
--1442: 20-5月 -16 03:45:40	20-5月 -16 15:58:06
--1443: 20-5月 -16 00:00:14	20-5月 -16 15:49:38

select min(btsj), max(btsj)
from itf_3g_header

select min(btsj), max(btsj)
from itf_tcms_hxd_v20

--查看同一路线、车型共跑了多少次
select lineno,t_type_id, count(*) num
from
(
select r2.lineno lineno, r1.t_type_id t_type_id, r1.loco_no loco_no
from 
(select t_type_id, loco_no, count(*) as num
from itf_tcms_hxd_v20
group by t_type_id, loco_no) r1, 
(select t_type_id, loco_no, lineno, count(*) as num
from itf_3g_header
group by t_type_id, loco_no, lineno) r2
where 1=1
and r1.t_type_id = 231
and r2.t_type_id = 231
and r1.loco_no = r2.loco_no
order by r1.t_type_id, r1.loco_no, r2.lineno
) t1
where 1=1
group by lineno,t_type_id
order by num desc

--V20_3G_INFO_precedure query
select r2.lineno lineno, r1.t_type_id t_type_id, r1.loco_no loco_no
from 
(select t_type_id, loco_no, count(*) as num
from itf_tcms_hxd_v20
group by t_type_id, loco_no) r1, 
(select t_type_id, loco_no, lineno, count(*) as num
from itf_3g_header
group by t_type_id, loco_no, lineno) r2
where 1=1
and r1.t_type_id = 231
and r2.t_type_id = 231
and r2.lineno = 56
and r1.loco_no = r2.loco_no
order by r1.t_type_id, r1.loco_no, r2.lineno

select r2.lineno lineno, r1.t_type_id t_type_id, r1.loco_no loco_no
from 
(select t_type_id, loco_no, count(*) as num
from itf_tcms_hxd_v20
group by t_type_id, loco_no) r1, 
(select t_type_id, loco_no, lineno, count(*) as num
from itf_3g_header
group by t_type_id, loco_no, lineno) r2
where 1=1
and r1.t_type_id = 231
and r2.t_type_id = 231
and r1.loco_no = r2.loco_no
order by r1.t_type_id, r1.loco_no, r2.lineno


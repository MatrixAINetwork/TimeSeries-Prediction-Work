--同一线路、车型、车次
select *
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
and r1.t_type_id = r2.t_type_id 
and r1.loco_no = r2.loco_no
order by r1.t_type_id, r1.loco_no, r2.lineno
) t1,
itf_tcms_hxd_v20 t2
where 1=1
and t1.t_type_id = t2.t_type_id
and t1.loco_no = t2.loco_no
and btsj >= (select min(btsj-5/24/60) from itf_3g_header as t3 where t1.lineno = t3.lineno and t1.t_type_id = t3.t_type_id and t1.loco_no = t2.loco_no)

(between (select min(btsj-5/24/60) from itf_3g_header as t3 where t1.lineno = t3.lineno and t1.t_type_id = t3.t_type_id and t1.loco_no = t2.loco_no)
and (select max(btsj+5/24/60) from itf_3g_header as t3 where t1.lineno = t3.lineno and t1.t_type_id = t3.t_type_id and t1.loco_no = t2.loco_no))

select *
from itf_tcms_hxd_v20
where 1=1
and t_type_id = 231
and loco_no = 1441
and btsj >= (select min(btsj-5/24/60) from itf_3g_header where lineno = 56 and t_type_id = 231 and loco_no = 1441)
and btsj <= (select min(btsj-5/24/60) from itf_3g_header where lineno = 56 and t_type_id = 231 and loco_no = 1441)

select *
from itf_3g_header t1
where 1=1
and t_type_id > (select min(t_type_id) from itf_tcms_hxd_v20 t2 where t1.loco_no = t2.loco_no)

select r2.lineno lineno, r1.t_type_id t_type_id, r1.loco_no loco_no
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
and rownum <= 10
order by r1.t_type_id, r1.loco_no, r2.lineno

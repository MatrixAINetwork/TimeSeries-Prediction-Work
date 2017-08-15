
--itf
select g.lineno,tc.t_type_id, tc.loco_no, tc.btsj
from itf_tcms_hxd_v20 tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
order by g.lineno, tc.t_type_id, tc.loco_no, tc.btsj asc

--itf_3g_header:同一线路，同一车次，同一车号记录总数目
select count(*)
from
(select lineno, t_type_id, loco_no, count(*) as num
from itf_3g_header
group by lineno, t_type_id, loco_no
order by num desc) r1
--9205

--itf_3g_header:同一线路，同一车次，同一车号记录数目
select lineno, t_type_id, loco_no, count(*) as num
from itf_3g_header
group by lineno, t_type_id, loco_no
order by num desc

--itf_tcmsfault_start:同一线路，同一车次，同一车号记录总数目
select count(*)
from 
(select cc, t_type_id, loco_no, count(*) as num
from itf_tcmsfault_start
group by cc, t_type_id, loco_no
order by num desc) r1

--itf_tcmsfault_start:同一线路，同一车次，同一车号记录数目
select cc, t_type_id, loco_no, count(*) as num
from itf_tcmsfault_start
group by cc, t_type_id, loco_no
order by num desc

--itf_tcmsfault_start & itf_tcms_hxd_v20
select r1.cc, r1.t_type_id, r1.loco_no, count(*) num
from 
(
--itf_tcmsfault_start
select cc, t_type_id, loco_no, count(*) as num
from itf_tcmsfault_start
group by cc, t_type_id, loco_no
order by num desc
) r1
(
--itf_tcms_hxd_v20
select g.lineno,tc.t_type_id, tc.loco_no, count(*) as num
from itf_tcms_hxd_v20 tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
--and tc.btsj = g.btsj
group by g.lineno, tc.t_type_id, tc.loco_no
) r2
where 1=1
and r1.cc = r2.cc
and r1.t_type_id = r2.t_type_id
and r1.loco_no = r2.loco_no
group by r1.cc, r1.t_type_id, r1.loco_no
order by num desc


--itf_6afault_start:
select g.lineno, tc.cc, tc.t_type_id, tc.loco_no, tc.btsj
from itf_6afault_start tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
order by g.lineno, tc.t_type_id, tc.loco_no, tc.btsj asc
--没有数据

--itf_tcms_hxd_v20:同一线路，同一车次，同意车号记录总数目
select g.lineno,tc.t_type_id, tc.loco_no, count(*) as num
from itf_tcms_hxd_v20 tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
group by g.lineno, tc.t_type_id, tc.loco_no
order by num desc

--itf_6a:同一线路，同一车次，同意车号记录数目
select g.lineno,tc.t_type_id, tc.loco_no, count(*) as num
from itf_6a tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
group by g.lineno, tc.t_type_id, tc.loco_no
order by num desc

select r1.lineno, r1.t_type_id, r1.loco_no, count(*) as num
from 
(
select g.lineno,tc.t_type_id, tc.loco_no, count(*) as num
from itf_tcms_hxd_v20 tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
group by g.lineno, tc.t_type_id, tc.loco_no
) r1,
(
select g.lineno,tc.t_type_id, tc.loco_no, count(*) as num
from itf_6a tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
group by g.lineno, tc.t_type_id, tc.loco_no
) r2
where r1.lineno = r2.lineno
and r1.t_type_id = r2.t_type_id
and r1.loco_no = r2.loco_no
group by r1.lineno, r1.t_type_id, r1.loco_no
order by num

/*itf_tcms_hxd_v20：数据联查数目*/
select count(*) 
from itf_tcms_hxd_v20 tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
--385,2915

/*itf_tcms_hxd_v20：同一线路，同一车次，同意车号记录总数目*/
select count(*)
from 
(
/*itf_tcms_hxd_v20：同一线路，同一车次，同意车号记录数目*/
select r2.lineno, r1.t_type_id, r1.loco_no, count(*) as num
from itf_tcms_hxd_v20 r1, itf_3g_header r2
where r1.t_type_id = r2.t_type_id 
and r1.loco_no = r2.loco_no
and r1.btsj = r2.btsj
group by r2.lineno, r1.t_type_id, r1.loco_no
order by r1.t_type_id, r1.loco_no, r2.lineno
) r1


select count(*) 
from itf_tcms_hxd_v20 tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
--2082,9822,0474

/*itf_6a: 数据联查数目*/
select count(*) 
from itf_6a tc, itf_3g_header g
where tc.t_type_id = g.t_type_id 
and tc.loco_no = g.loco_no
and tc.btsj = g.btsj
--2500,6648


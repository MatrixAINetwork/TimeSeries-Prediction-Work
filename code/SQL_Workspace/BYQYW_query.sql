--ITF_TCMSFAULT_START:变压器油温记录
select * from ITF_TCMSFAULT_START
where GZDM = 1070
and t_type_id = 237

--ITF_TCMSFAULT_START:237车型-不同车号变压器油温记录数目
select loco_no, count(*) num 
from ITF_TCMSFAULT_START
where GZDM = 1070
and t_type_id = 237
group by loco_no
order by num desc

--ITF_TCMSFAULT_START & ITF_TCMS_HXD_V20: 237车型-同一车号的变压器油温记录
select r1.loco_no, r1.num as fault_num, r2.num tcms_num
from
(select loco_no, count(*) num 
from ITF_TCMSFAULT_START
where GZDM = 1070
and t_type_id = 237
group by loco_no) r1,
(select loco_no, count(*) num from ITF_TCMS_HXD_V20
where t_type_id = 237
group by loco_no) r2
where r1.loco_no = r2.loco_no

--ITF_TCMSFAULT_START:变压器油温记录总数
select count(*) from ITF_TCMSFAULT_START
where GZDM = 1070
--27,4616

--ITF_TCMSFAULT_START:变压器油温分车型记录数目
select t_type_id, count(*) as num 
from ITF_TCMSFAULT_START
where GZDM = 1070
group by t_type_id
order by num desc

--ITF_TCMSFAULT_START 表中故障 1070 在 ITF_TCMS_HXN_V20 中有的车型
select *
from
(select t_type_id, count(*) as num 
from ITF_TCMSFAULT_START
where GZDM = 1070
group by t_type_id
order by num desc) r1
where r1.t_type_id in
(select t_type_id from ITF_TCMS_HXD_V20
group by t_type_id)

--ITF_TCMS_HXD_V20:237车型-变压器油温记录
select * from ITF_TCMS_HXD_V20
where t_type_id = 237
order by BTSJ

--ITF_TCMS_HXD_V20:237车型-不同车号变压器油温记录数目
select loco_no, count(*) num from ITF_TCMS_HXD_V20
where t_type_id = 237
group by loco_no
order by num desc

--itf_tcms_hxd_v20:237型-352号记录
select *
from itf_tcms_hxd_v20
where 1=1
and t_type_id = 237
and loco_no = 352
order by btsj

--itf_tcmsfault_start:237型-447号记录
select *
from itf_tcmsfault_start
where 1=1
and gzdm = 1070
and t_type_id = 237
and loco_no = 352
order by btsj


select yx_ybdy, yx_ybdl from itf_tcms_hxd_v20
where 1=1 
and t_type_id = 240     
and loco_no = 142 
and btsj between to_date('2016-04-15', 'yyyy-mm-dd')+1/24/60/60 and to_date('2016-04-15', 'yyyy-mm-dd')+1-1/24/60/60 order by btsj asc
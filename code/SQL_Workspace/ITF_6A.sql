/*数据总数：*/
select count(*) from ITF_6A where t_type_id = 242

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
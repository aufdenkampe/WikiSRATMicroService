-- Issue with wiki error for 
HUC10  020402050303

select distinct huc12  
from wikiwtershed.nhdplus_x_huc12 
where huc12 like '0204020503%'

"huc12"
"020402050308"
"020402050306"
"020402050305"
"020402050302"
"020402050301"
"020402050307"
"020402050303"
"020402050304"
020402050303
-- Error was found here 020402050303


Select * From wikiwtershed.nhdplus_x_huc12
where huc12 like '020402050303'


Select *   
From wikiwtershed.huc12_att
where huc12 like '020402050303'





select t2.*
from
(
  SELECT comid, huc12, catareasqkm, shedareadrainlake, p_tnsumgrnd_x_huc12
  FROM wikiwtershed.cache_nhdcoefs
  where huc12 like '020402050303'
) t1
join
(
select * from wikiwtershed.comid_routing
) t2
on  t1.comid = t2.comid


select 
*
from wikiwtershed.comid_routing
where d_comid is null

  -- Check Calc of Shed Drain Lake by COMID
-- Original Calc is here 

OALESCE(t1.pctow2011cat, 0::double precision) 
+ COALESCE(t1.pctwdwet2011cat, 0::double precision) 
+ COALESCE(t1.pcthbwet2011cat, 0::double precision) 
AS shedareadrainlake
  



drop view if exists wikiwtershed.qaqc;

create view wikiwtershed.qaqc as 

SELECT 
	geom.comid, 
	nhd.shedareadrainlake,
	pctow2011cat,
	pcthbwet2011cat,
	pctwdwet2011cat,
	
	geom.geom
  FROM 
	wikiwtershed.nhdplus_stream geom
	join
	wikiwtershed.nhdplus_x_huc12 huc
	on geom.comid = huc.comid

	left outer join 
	wikiwtershed.cache_nhdcoefs nhd
	on geom.comid = nhd.comid

	join 
	wikiwtershed.strmcat11 cat
	on geom.comid = cat.comid

where nhd.huc12 like '020401%';
SELECT comid, huc12, catareasqkm, shedareadrainlake, p_tnsumgrnd_x_huc12
  FROM wikiwtershed.cache_nhdcoefs
  where huc12 like '020503010903'



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
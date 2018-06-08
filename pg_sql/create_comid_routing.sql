--  Create Better Link Table using COMID
--  This is necessary because the original link table form NHDPLUS 
--  wikiwtershed.nhdplus_stream_nsidx has many links where the area is null
--  I need to create a new link table that finds the closest downstream value that is in the output table


-- TestCaset 4651860 links to 

Select * from wikiwtershed.nhdplus_stream_nsidx where comid = 4651860
Select * from wikiwtershed.nhdplus_stream_nsidx where hydroseq = 200045280


select count(*) from     wikiwtershed.nhdplus_x_huc12 x 
             -- 2647454   
  
select count(*) from     wikiwtershed.cache_nhdcoefs cfs
	      --2647057

select 1
,sum( case when x.comid is not null then 1 else 0 end)
,sum( case when cfs.comid is not null then 1 else 0 end)
,sum( case when x.comid is not null and cfs.comid is not null then 1 else 0 end)
from wikiwtershed.nhdplus_x_huc12 x 
	full outer join
	wikiwtershed.cache_nhdcoefs cfs
	on x.comid = cfs.comid
group by 1


create Table wikiwtershed.comid_routing as 
Select t1.comid, -- t2.comid, t3.comid, t4.comid,
case 
	when filter2.comid is not null then t2.comid
	when filter4.comid is not null then t3.comid
	when filter4.comid is not null then t4.comid
	else null end d_comid,
case 
	when filter2.comid is not null then 1
	when filter4.comid is not null then 2
	when filter4.comid is not null then 3
	else null end d_pos 


	 
From 
	(select * from wikiwtershed.nhdplus_stream_nsidx --limit 1000000 -- where comid = 4651860
	) t1

	join
	wikiwtershed.cache_nhdcoefs filter1
	on t1.comid = filter1.comid 
	
	left outer join
	wikiwtershed.nhdplus_stream_nsidx t2
	on t1.dnhydroseq = t2.hydroseq 

	left outer join
	wikiwtershed.cache_nhdcoefs filter2
	on t2.comid = filter2.comid 

	left outer join
	wikiwtershed.nhdplus_stream_nsidx t3
	on t2.dnhydroseq = t3.hydroseq

	left outer join
	wikiwtershed.cache_nhdcoefs filter3
	on t3.comid = filter3.comid 
	
	left outer join
	wikiwtershed.nhdplus_stream_nsidx t4
	on t3.dnhydroseq = t4.hydroseq

	left outer join
	wikiwtershed.cache_nhdcoefs filter4
	on t4.comid = filter4.comid 


Grant Select on wikiwtershed.comid_routing to ms_select

ALTER TABLE wikiwtershed.comid_routing
  ADD PRIMARY KEY (comid);

	
	
-- Setting up the data 

alter table wikiwtershed.ms_pointsource_drb_12_13_18 add column comid integer
select comid from wikiwtershed.ms_pointsource 

update wikiwtershed.ms_pointsource_drb_12_13_18 old
set comid = new.comid
from (select * from spatial.nhdplus) new
where ST_Intersects(new.catchment, old.geom)


create table   wikiwtershed.nhdplus_qe_ma as 
Select comid, qe_ma from wikiwtershed.nhdplus_stream;

Select * from wikiwtershed.nhdplus_stream limit 1;


ALTER TABLE wikiwtershed.nhdplus_qe_ma
  ADD CONSTRAINT qe_ma3 PRIMARY KEY(comid);


alter table wikiwtershed.nhdplus_qe_ma


alter table wikiwtershed.ms_pointsource add column in_drb text;

update wikiwtershed.ms_pointsource set in_drb = 'false'

update wikiwtershed.ms_pointsource old
set in_drb = 'true'
from ( select * from spatial.drbbounds ) filter
where ST_Intersects(old.geom,ST_transform(filter.geom,4326))


Drop Table if exists wikiwtershed.cache_nhdcoefs2;

set enable_seqscan = off;

Create Table wikiwtershed.cache_nhdcoefs2 as 
Select * From wikiwtershed.nhdcoefs;

set enable_seqscan = on;



ALTER TABLE wikiwtershed.cache_nhdcoefs2
  ADD CONSTRAINT nhdpluscoefspk5 PRIMARY KEY(comid);

CREATE INDEX 
   ON wikiwtershed.cache_nhdcoefs2 (huc12 ASC NULLS LAST);

ALTER TABLE wikiwtershed.cache_nhdcoefs2
  ADD FOREIGN KEY (huc12) REFERENCES wikiwtershed.boundary_huc12 (huc12)
   ON UPDATE NO ACTION ON DELETE NO ACTION;
CREATE INDEX huc12foreignkeycoefs21a
  ON wikiwtershed.cache_nhdcoefs2(huc12);

Grant Select on table wikiwtershed.cache_nhdcoefs2 to ms_select;


 
Drop Table If Exists wikiwtershed.cache_nhdcoefs_old;



Alter Table wikiwtershed.cache_nhdcoefs rename to cache_nhdcoefs_old;

Alter Table wikiwtershed.cache_nhdcoefs2 rename to cache_nhdcoefs;


Grant Select on table wikiwtershed.cache_nhdcoefs to ms_select;


-- I fixed the qe_ma problem 12_13_18 the original file was short ( shapefile from geodatabase ) 
-- more notes are in the qe_ma process file
Drop View if Exists wikiwtershed.cache_nhdcoefs_sp;
Create view wikiwtershed.cache_nhdcoefs_sp as
Select
t1.*
,ST_Centroid(t2.geom_stream) as geom
From 
 wikiwtershed.cache_nhdcoefs t1
 join
 wikiwtershed.nhdplus_streamgeom t2 
 on t1.comid = t2.comid
 

Select sum(qe_ma) from wikiwtershed.cache_nhdcoefs2

 drop table wikiwtershed.cache_nhdcoefs2

	
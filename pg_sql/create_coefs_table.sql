-- Setting up the data 

Drop Table if exists wikiwtershed.cache_nhdcoefs2;

set enable_seqscan = off;

Create Table wikiwtershed.cache_nhdcoefs2 as 
Select * From wikiwtershed.nhdcoefs;

set enable_seqscan = on;



ALTER TABLE wikiwtershed.cache_nhdcoefs2
  ADD CONSTRAINT nhdpluscoefspk3 PRIMARY KEY(comid);

CREATE INDEX 
   ON wikiwtershed.cache_nhdcoefs3 (huc12 ASC NULLS LAST);

ALTER TABLE wikiwtershed.cache_nhdcoefs2
  ADD FOREIGN KEY (huc12) REFERENCES wikiwtershed.boundary_huc12 (huc12)
   ON UPDATE NO ACTION ON DELETE NO ACTION;
CREATE INDEX huc12foreignkeycoefs2
  ON wikiwtershed.cache_nhdcoefs2(huc12);

Grant Select on table wikiwtershed.cache_nhdcoefs2 to ms_select;

Drop Table If Exists wikiwtershed.cache_nhdcoefs;

Alter Table wikiwtershed.cache_nhdcoefs2 rename to cache_nhdcoefs


Grant Select on table wikiwtershed.cache_nhdcoefs to ms_select;

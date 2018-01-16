-- Setting up the data 
Drop Table If Exists wikiwtershed.cache_nhdcoefs;

set enable_seqscan = off;

Create Table wikiwtershed.cache_nhdcoefs as 
Select * From wikiwtershed.nhdcoefs;

set enable_seqscan = on;

ALTER TABLE wikiwtershed.cache_nhdcoefs
  ADD CONSTRAINT nhdpluscoefspk PRIMARY KEY(comid);

CREATE INDEX 
   ON wikiwtershed.cache_nhdcoefs (huc12 ASC NULLS LAST);

ALTER TABLE wikiwtershed.cache_nhdcoefs
  ADD FOREIGN KEY (huc12) REFERENCES wikiwtershed.boundary_huc12 (huc12)
   ON UPDATE NO ACTION ON DELETE NO ACTION;
CREATE INDEX huc12foreignkeycoefs2
  ON wikiwtershed.cache_nhdcoefs(huc12);



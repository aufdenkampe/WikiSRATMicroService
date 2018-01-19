 
 
Alter Table wikiwtershed.ms_pointsource add column comid integer;

Update wikiwtershed.ms_pointsource old
set comid = new.comid
From wikiwtershed.nhdplus_catchgeom new
Where ST_intersects(new.geom_catch,old.geom);

CREATE INDEX 
   ON wikiwtershed.nhdplus_catchgeom (comid ASC NULLS LAST);
 
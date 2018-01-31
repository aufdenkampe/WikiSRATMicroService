-- Setting up the data 
Create Table wikiwtershed.nhdcoefs as 
Select comid, huc12, 1 / count(*) over (partition by huc12) as ag_tn_coef

From wikiwtershed.nhdplus;

ALTER TABLE wikiwtershed.nhdcoefs
  ADD CONSTRAINT nhdpluscoefspk PRIMARY KEY(comid);

CREATE INDEX 
   ON wikiwtershed.nhdplus (huc12 ASC NULLS LAST);

ALTER TABLE wikiwtershed.nhdcoefs
  ADD FOREIGN KEY (huc12) REFERENCES wikiwtershed.boundary_huc12 (huc12)
   ON UPDATE NO ACTION ON DELETE NO ACTION;
CREATE INDEX huc12foreignkeycoefs2
  ON wikiwtershed.nhdcoefs(huc12);


Select * From wikiwtershed.nhdcoefs limit 10;

Drop Function 
wikiwtershed.srat
(
huc12a character varying(12)[]
,tploadhp float[]
,tploadCrop float[]
,tploadWooded float[]
,tploadOpen float[]
,tploadbarren float[]
,tploadldm float[]
,tploadMDM float[]
,tploadHDM float[]
,tploadOtherUp float[]
,tploadFarmAn float[]
,tploadtiledrain float[]
,tploadstreambank  float[]
,tploadsubsurface  float[]
,tploadpointsource float[]
,tploadseptics float[]
);
 
CREATE OR REPLACE FUNCTION 
wikiwtershed.srat
(
huc12a character varying(12)[]
,tploadhp float[]
,tploadCrop float[]
,tploadWooded float[]
,tploadOpen float[]
,tploadbarren float[]
,tploadldm float[]
,tploadMDM float[]
,tploadHDM float[]
,tploadOtherUp float[]
,tploadFarmAn float[]
,tploadtiledrain float[]
,tploadstreambank  float[]
,tploadsubsurface  float[]
,tploadpointsource float[]
,tploadseptics float[]
)


RETURNS TABLE (id integer, ag_tn_ld_nhd float ) AS $$
BEGIN
Create temporary table tmp as 
(
select 1
);

drop  table tmp;



    RETURN QUERY Select comid, 10::float from wikiwtershed.nhdplus where huc12 = any(huc12a);
END;
$$ LANGUAGE plpgsql;




Select * From  wikiwtershed.srat(
array['030701020406','030701020406']::character varying(12)[] 
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
,array[10.0,25]::float[]
)


Select comid, 10::float From wikiwtershed.nhdplus Where 
huc12 like '030701020406'

 any(array['030701020406','030701020406']::character varying(12)[] )




    
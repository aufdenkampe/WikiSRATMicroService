-- File to Proces the Nutrient Grid Sent By barry Evans
-- grid called natl_gwn
-- merged with the stream catchment files using arcgis 
-- from the NHDPlusv2 natiowide GIS file

-- exported the original raster as 100 meter grid cells 100x100
-- this is needed to get underneath the zonaal stastiics issues 

--# Replace a layer/table view name with a path to a dataset (which can be a layer file) or create the layer/table view within the script
--# The following inputs are layers or table views: "Catchment", "natl_gwn"

-- MAKE SURE YOU SET CELL RASTER ANALYSIS TO 10

--arcpy.gp.ZonalStatisticsAsTable_sa("Catchment","comid","natl_gwn","C:/Users/smh362/Documents/ArcGIS/Default.gdb/ZonalSt_Catchme4","DATA","ALL")

Drop Table If Exists wikiwtershed.grndwter_tn_nhdplus ;

CREATE TABLE wikiwtershed.grndwter_tn_nhdplus2 
(
objectid text,
comid text,
ZONE_CODE text,
COUNT text, 
AREA text,
min text,
max text,
range text,
mean text,
std text,
SUM text
);


COPY wikiwtershed.grndwter_tn_nhdplus2 
FROM '/tmp/tn_10m.csv' 
WITH CSV HEADER DELIMITER AS ',';

Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column rowid;
Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column ZONE_CODE;
Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column COUNT;
Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column AREA;

Select * From wikiwtershed.grndwter_tn_nhdplus2 where comid in ('4518358','4518380')
Select * From wikiwtershed.grndwter_tn_nhdplus where comid in (4518358,4518380)

"comid";"sum"
4518380;51.3250846862793
4518358;1255.62159724534



ALTER TABLE wikiwtershed.grndwter_tn_nhdplus2
  ADD PRIMARY KEY (comid);


select sum from  wikiwtershed.grndwter_tn_nhdplus2 limit 10

Alter  Table wikiwtershed.grndwter_tn_nhdplus2 Alter Column SUM Type float using (replace(SUM, ',' ,'' ))::float;
Alter  Table wikiwtershed.grndwter_tn_nhdplus2 Alter Column comid Type integer using comid::integer;

 

ALTER TABLE wikiwtershed.grndwter_tn_nhdplus2
  ADD FOREIGN KEY (comid) REFERENCES wikiwtershed.nhdplus_x_huc12 (comid)
   ON UPDATE NO ACTION ON DELETE NO ACTION;



-- UPdate Cache table for NHD



COALESCE(nut.tnsumgrnd, 0::double precision) AS tnsumgrnd,


SELECT grndwter_tn_nhdplus.comid, grndwter_tn_nhdplus.sum AS tnsumgrnd
              FROM wikiwtershed.



        CASE
            WHEN sum(tmp.tnsumgrnd) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.tnsumgrnd / sum(tmp.tnsumgrnd) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_tnsumgrnd_x_huc12


nhdplus_x_huc12.comid

Select * 

From wikiwtershed.grndwter_tn_nhdplus
where COMID = 4518358 or COMID = 4518380



Drop table wikiwtershed.grndwter_tn_nhdplus

Alter table wikiwtershed.grndwter_tn_nhdplus2 rename to grndwter_tn_nhdplus;

Update wikiwtershed.cache_nhdcoefs
set p_tnsumgrnd_x_huc12 = 0;

Update wikiwtershed.cache_nhdcoefs old
set p_tnsumgrnd_x_huc12 = new.p_tnsumgrnd_x_huc12
From
(
select huc.comid,
        CASE
            WHEN sum(grn.sum) OVER (PARTITION BY huc.huc12) > 0::double precision THEN grn.sum / sum(grn.sum) OVER (PARTITION BY huc.huc12)
            ELSE NULL::double precision
        END AS p_tnsumgrnd_x_huc12
From wikiwtershed.nhdplus_x_huc12 huc join wikiwtershed.grndwter_tn_nhdplus grn
on huc.comid = grn.comid
) new
where old.comid = new.comid;










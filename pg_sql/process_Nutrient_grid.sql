-- File to Proces the Nutrient Grid Sent By barry Evans
-- grid called natl_gwn
-- merged with the stream catchment files using arcgis 
-- from the NHDPlusv2 natiowide GIS file

-- exported the original raster as 100 meter grid cells 100x100
-- this is needed to get underneath the zonaal stastiics issues 

--# Replace a layer/table view name with a path to a dataset (which can be a layer file) or create the layer/table view within the script
--# The following inputs are layers or table views: "Catchment", "natl_gwn_100x100.tif"
--arcpy.gp.ZonalStatisticsAsTable_sa("Catchment","comid","natl_gwn_100x100.tif","E:/nhd_natltn_100x100","DATA","SUM")

Drop Table If Exists wikiwtershed.grndwter_tn_nhdplus ;

CREATE TABLE wikiwtershed.grndwter_tn_nhdplus 
(
rowid text,
comid text,
ZONE_CODE text,
COUNT text, 
AREA text,
SUM text
);


COPY wikiwtershed.grndwter_tn_nhdplus 
FROM '/home/drwi-user/nhd_natltn_1_26_18.csv' 
WITH CSV HEADER DELIMITER AS ',';

Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column rowid;
Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column ZONE_CODE;
Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column COUNT;
Alter Table wikiwtershed.grndwter_tn_nhdplus  Drop Column AREA;

Select * From wikiwtershed.grndwter_tn_nhdplus limit 10

ALTER TABLE wikiwtershed.grndwter_tn_nhdplus
  ADD PRIMARY KEY (comid);


Alter  Table wikiwtershed.grndwter_tn_nhdplus Alter Column SUM Type float using (replace(SUM, ',' ,'' ))::float;




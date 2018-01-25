-- File to Proces the Nutrient Grid Sent By barry Evans
-- grid called natl_gwn
-- merged with the stream catchment files using arcgis 
-- from the NHDPlusv2 natiowide GIS file

-- exported the original raster as 100 meter grid cells 100x100
-- this is needed to get underneath the zonaal stastiics issues 


-- # Replace a layer/table view name with a path to a dataset (which can be a layer file) or create the layer/table view within the script
--# The following inputs are layers or table views: "Catchment", "natl_gwn"
--arcpy.gp.ZonalStatisticsAsTable_sa("Catchment","FEATUREID","natl_gwn","C:/Users/smh362/Documents/ArcGIS/Default.gdb/ZonalSt_Catchme3","DATA","ALL")


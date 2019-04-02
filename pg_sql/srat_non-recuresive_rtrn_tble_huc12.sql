
-- Function: wikiwtershed.srat_strmbank(character varying[], double precision[])
-- To Do Calculate total sum for each reach
SET SESSION AUTHORIZATION 'drwiadmin';
-- DROP FUNCTION wikiwtershed.srat_tst(character varying[]);

-- Uppdate from Barry Use the Other_up slot to put in low density open space email from 10.2.18

-- DROP FUNCTION wikiwtershed.srat_tst(character varying[]);
-- Function: wikiwtershed.srat_huc12(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[])

-- DROP FUNCTION wikiwtershed.srat_huc12(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]);
-- Function: wikiwtershed.srat_huc12(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[])

tpload_septics float [],
tnload_hp float [],
tnload_crop float [],
tnload_wooded float [],
tnload_open float [],
tnload_barren float [],
tnload_ldm float [],
tnload_mdm float [],
tnload_hdm float [],
tnload_otherup float [],
tnload_farman float [],
tnload_tiledrain float [],
tnload_streambank float [],
tnload_subsurface float [],
tnload_pointsource float [],
tnload_septics float [],

tssload_hp float [],
tssload_crop float [],
tssload_wooded float [],
tssload_open float [],
tssload_barren float [],
tssload_ldm float [],
tssload_mdm float [],
tssload_hdm float [],
tssload_otherup float [],
tssload_tiledrain float [],
tssload_streambank float []

CREATE OR REPLACE FUNCTION wikiwtershed.srat_huc12(IN huc12a character varying[], IN tpload_hp double precision[], IN tpload_crop double precision[], IN tpload_wooded double precision[], IN tpload_open double precision[], IN tpload_barren double precision[], IN tpload_ldm double precision[], IN tpload_mdm double precision[], IN tpload_hdm double precision[], IN tpload_otherup double precision[], IN tpload_farman double precision[], IN tpload_tiledrain double precision[], IN tpload_streambank double precision[], IN tpload_subsurface double precision[], IN tpload_pointsource double precision[], IN tpload_septics double precision[], IN tnload_hp double precision[], IN tnload_crop double precision[], IN tnload_wooded double precision[], IN tnload_open double precision[], IN tnload_barren double precision[], IN tnload_ldm double precision[], IN tnload_mdm double precision[], IN tnload_hdm double precision[], IN tnload_otherup double precision[], IN tnload_farman double precision[], IN tnload_tiledrain double precision[], IN tnload_streambank double precision[], IN tnload_subsurface double precision[], IN tnload_pointsource double precision[], IN tnload_septics double precision[], IN tssload_hp double precision[], IN tssload_crop double precision[], IN tssload_wooded double precision[], IN tssload_open double precision[], IN tssload_barren double precision[], IN tssload_ldm double precision[], IN tssload_mdm double precision[], IN tssload_hdm double precision[], IN tssload_otherup double precision[], IN tssload_tiledrain double precision[], IN tssload_streambank double precision[])
  RETURNS TABLE(huc12a_out character varying, tpload_hp_out double precision, tpload_crop_out double precision, tpload_wooded_out double precision, tpload_open_out double precision, tpload_barren_out double precision, tpload_ldm_out double precision, tpload_mdm_out double precision, tpload_hdm_out double precision, tpload_otherup_out double precision, tpload_farman_out double precision, tpload_tiledrain_out double precision, tpload_streambank_out double precision, tpload_subsurface_out double precision, tpload_pointsource_out double precision, tpload_septics_out double precision, tnload_hp_out double precision, tnload_crop_out double precision, tnload_wooded_out double precision, tnload_open_out double precision, tnload_barren_out double precision, tnload_ldm_out double precision, tnload_mdm_out double precision, tnload_hdm_out double precision, tnload_otherup_out double precision, tnload_farman_out double precision, tnload_tiledrain_out double precision, tnload_streambank_out double precision, tnload_subsurface_out double precision, tnload_pointsource_out double precision, tnload_septics_out double precision, tssload_hp_out double precision, tssload_crop_out double precision, tssload_wooded_out double precision, tssload_open_out double precision, tssload_barren_out double precision, tssload_ldm_out double precision, tssload_mdm_out double precision, tssload_hdm_out double precision, tssload_otherup_out double precision, tssload_tiledrain_out double precision, tssload_streambank_out double precision, comid_out text[]) AS
$BODY$

BEGIN

Drop Table If Exists huc12_out;

-- Create Temporary Output Tables 
CREATE TEMP TABLE huc12_out 
(
huc12 character varying(12)not null,
tpload_hp float Default 0,
tpload_Crop  float Default 0,
tpload_Wooded  float Default 0,
tpload_Open  float Default 0,
tpload_barren  float Default 0,
tpload_ldm  float Default 0,
tpload_MDM  float Default 0,
tpload_HDM  float Default 0,
tpload_OtherUp  float Default 0,
tpload_FarmAn  float Default 0,
tpload_tiledrain  float Default 0,
tpload_streambank  float Default 0,
tpload_subsurface  float Default 0,
tpload_pointsource  float Default 0,
tpload_septics  float Default 0,
tnload_hp  float Default 0,
tnload_crop  float Default 0,
tnload_wooded  float Default 0,
tnload_open  float Default 0,
tnload_barren  float Default 0,
tnload_ldm  float Default 0,
tnload_mdm  float Default 0,
tnload_hdm  float Default 0,
tnload_otherup  float Default 0,
tnload_farman  float Default 0,
tnload_tiledrain  float Default 0,
tnload_streambank  float Default 0,
tnload_subsurface  float Default 0,
tnload_pointsource  float Default 0,
tnload_septics  float Default 0,
tssload_hp  float Default 0,
tssload_crop  float Default 0,
tssload_wooded  float Default 0,
tssload_open  float Default 0,
tssload_barren  float Default 0,
tssload_ldm  float Default 0,
tssload_mdm  float Default 0,
tssload_hdm  float Default 0,
tssload_otherup  float Default 0,
tssload_tiledrain  float Default 0,
tssload_streambank  float Default 0,

tpload_hp_att float Default 0,
tpload_Crop_att  float Default 0,
tpload_Wooded_att  float Default 0,
tpload_Open_att  float Default 0,
tpload_barren_att  float Default 0,
tpload_ldm_att  float Default 0,
tpload_MDM_att  float Default 0,
tpload_HDM_att  float Default 0,
tpload_OtherUp_att  float Default 0,
tpload_FarmAn_att  float Default 0,
tpload_tiledrain_att  float Default 0,
tpload_streambank_att  float Default 0,
tpload_subsurface_att  float Default 0,
tpload_pointsource_att  float Default 0,
tpload_septics_att  float Default 0,
tnload_hp_att  float Default 0,
tnload_crop_att  float Default 0,
tnload_wooded_att  float Default 0,
tnload_open_att  float Default 0,
tnload_barren_att  float Default 0,
tnload_ldm_att  float Default 0,
tnload_mdm_att  float Default 0,
tnload_hdm_att  float Default 0,
tnload_otherup_att  float Default 0,
tnload_farman_att  float Default 0,
tnload_tiledrain_att  float Default 0,
tnload_streambank_att  float Default 0,
tnload_subsurface_att  float Default 0,
tnload_pointsource_att  float Default 0,
tnload_septics_att  float Default 0,
tssload_hp_att  float Default 0,
tssload_crop_att  float Default 0,
tssload_wooded_att  float Default 0,
tssload_open_att  float Default 0,
tssload_barren_att  float Default 0,
tssload_ldm_att  float Default 0,
tssload_mdm_att  float Default 0,
tssload_hdm_att  float Default 0,
tssload_otherup_att  float Default 0,
tssload_tiledrain_att  float Default 0,
tssload_streambank_att  float Default 0,
comid text[],
CONSTRAINT huc12_tmp_primary  PRIMARY KEY (huc12)
) ON COMMIT DROP;


 

set enable_seqscan = off;

-- Insert
Insert into huc12_out 
(huc12,
tpload_hp,
tpload_Crop,
tpload_Wooded,
tpload_Open,
tpload_barren,
tpload_ldm,
tpload_MDM,
tpload_HDM,
tpload_OtherUp,
tpload_FarmAn,
tpload_tiledrain,
tpload_streambank,
tpload_subsurface,
tpload_pointsource,
tpload_septics,
tnload_hp,
tnload_crop,
tnload_wooded,
tnload_open,
tnload_barren,
tnload_ldm,
tnload_mdm,
tnload_hdm,
tnload_otherup,
tnload_farman,
tnload_tiledrain,
tnload_streambank,
tnload_subsurface,
tnload_pointsource,
tnload_septics,
tssload_hp,
tssload_crop,
tssload_wooded,
tssload_open,
tssload_barren,
tssload_ldm,
tssload_mdm,
tssload_hdm,
tssload_otherup,
tssload_tiledrain,
tssload_streambank 

)
Select unnest(huc12a) as huc12a, 
unnest(                tpload_hp),
unnest(                tpload_Crop),
unnest(                tpload_Wooded),
unnest(                tpload_Open),
unnest(                tpload_barren),
unnest(                tpload_ldm),
unnest(                tpload_MDM),
unnest(                tpload_HDM),
unnest(                tpload_OtherUp),
unnest(                tpload_FarmAn),
unnest(                tpload_tiledrain),
unnest(                tpload_streambank),
unnest(                tpload_subsurface),
unnest(                tpload_pointsource),
unnest(                tpload_septics),
unnest(                tnload_hp),
unnest(                tnload_crop),
unnest(                tnload_wooded),
unnest(                tnload_open),
unnest(                tnload_barren),
unnest(                tnload_ldm),
unnest(                tnload_mdm),
unnest(                tnload_hdm),
unnest(                tnload_otherup),
unnest(                tnload_farman),
unnest(                tnload_tiledrain),
unnest(                tnload_streambank),
unnest(                tnload_subsurface),
unnest(                tnload_pointsource),
unnest(                tnload_septics),
unnest(                tssload_hp),
unnest(                tssload_crop),
unnest(                tssload_wooded),
unnest(                tssload_open),
unnest(                tssload_barren),
unnest(                tssload_ldm),
unnest(                tssload_mdm),
unnest(                tssload_hdm),
unnest(                tssload_otherup),
unnest(                tssload_tiledrain),
unnest(                tssload_streambank )
;

-- Send in the outputs

Update huc12_out old
Set 
	tpload_hp_att 		= old.tpload_hp 	* new.hay2011_tp_att_coef,
	tpload_Crop_att 	= old.tpload_Crop 	* new.crop2011_tp_att_coef,
	tpload_Wooded_att 	= old.tpload_Wooded 	* new.all_forest2011cat_tp_att_coef,
 	tpload_Open_att 	= old.tpload_Open 	* new.grs2011_tp_att_coef,
	tpload_barren_att 	= old.tpload_barren 	* new.bl2011_tp_att_coef,

--	tpload_ldm_att 		= old.tpload_ldm 	* new.lowdensity2011cat_tp_att_coef,
--	Replaced with just the low density seperate out open space based on 10.9.18 phone call bme
	tpload_ldm_att 		= old.tpload_ldm 	* new.urblo2011_tp_att_coef,

	tpload_MDM_att 		= old.tpload_MDM 	* new.urbmd2011_tp_att_coef,
	tpload_HDM_att 		= old.tpload_HDM 	* new.urbhi2011_tp_att_coef,
 	tpload_OtherUp_att 	= old.tpload_OtherUp	* new.all_wetland2011cat_tp_att_coef,
	tpload_FarmAn_att 	= old.tpload_FarmAn 	* new.all_farm2011cat_tp_att_coef,


--	Update based on phone call and email from BME 10.9.18 use tile drain for open space developed
	tpload_tiledrain_att 	= old.tpload_tiledrain * urbop2011_tp_att_coef,


-- Added this 10.2.18 based on conversation with BME
-- Smaller models have lower values for streambank
	tpload_streambank_att 	= (old.tpload_streambank * 1.25 ) * new.streambnk_tp_att_coef,
	-- New 5_22_18
	tpload_subsurface_att   = old.tpload_subsurface * new.grnd_tp_att_coef,
	tpload_pointsource_att = old.tpload_pointsource * new.pt_2011_tp_att_coef   ,
	tpload_septics_att     = old.tpload_septics	* new.lowdensity2011cat_tp_att_coef,

	tnload_hp_att 		= old.tnload_hp 	* new.hay2011_tn_att_coef,
	tnload_Crop_att 	= old.tnload_Crop 	* new.crop2011_tn_att_coef,
	tnload_Wooded_att 	= old.tnload_Wooded 	* new.all_forest2011cat_tn_att_coef,
 	tnload_Open_att 	= old.tnload_Open 	* new.grs2011_tn_att_coef,
	tnload_barren_att 	= old.tnload_barren 	* new.bl2011_tn_att_coef,
	
--	tnload_ldm_att 		= old.tnload_ldm 	* new.lowdensity2011cat_tn_att_coef,
--	Replaced with just the low density seperate out open space based on 10.9.18 phone call bme
	tnload_ldm_att 		= old.tnload_ldm 	* new.urblo2011_tn_att_coef,

	
	tnload_MDM_att 		= old.tnload_MDM 	* new.urbmd2011_tn_att_coef,
	tnload_HDM_att 		= old.tnload_HDM 	* new.urbhi2011_tn_att_coef,
 	tnload_OtherUp_att 	= old.tnload_OtherUp	* new.all_wetland2011cat_tn_att_coef,
	tnload_FarmAn_att 	= old.tnload_FarmAn 	* new.all_farm2011cat_tn_att_coef,
	
--	Update based on phone call and email from BME 10.9.18 use tile drain for open space developed
	tnload_tiledrain_att 	= old.tnload_tiledrain * urbop2011_tn_att_coef,


-- Added this 10.2.18 based on conversation with BME
-- Smaller models have lower values for streambank
	tnload_streambank_att 	= ( old.tnload_streambank * 1.25 )* new.streambnk_tp_att_coef,

	-- New 5_22_18
	tnload_subsurface_att   = old.tnload_subsurface * new.grnd_tn_att_coef,
	tnload_pointsource_att = old.tnload_pointsource * new.pt_2011_tn_att_coef ,
	tnload_septics_att     = old.tnload_septics	* new.lowdensity2011cat_tn_att_coef,

	tssload_hp_att 		= old.tssload_hp 	* new.hay2011_tss_att_coef,
	tssload_Crop_att 	= old.tssload_Crop 	* new.crop2011_tss_att_coef,
	tssload_Wooded_att 	= old.tssload_Wooded 	* new.all_forest2011cat_tss_att_coef,
	-- 10.2.18 GRS from stream cat is grassland/herbaceous cat 71
 	tssload_Open_att 	= old.tssload_Open 	* new.grs2011_tp_att_coef,
	tssload_barren_att 	= old.tssload_barren 	* new.bl2011_tss_att_coef,
	
--	tssload_ldm_att 	= old.tssload_ldm 	* new.lowdensity2011cat_tss_att_coef,
--	Replaced with just the low density seperate out open space based on 10.9.18 phone call bme
	tssload_ldm_att 	= old.tssload_ldm 	* new.urblo2011_tss_att_coef,
	
	tssload_MDM_att 	= old.tssload_MDM 	* new.urbmd2011_tss_att_coef,
	tssload_HDM_att 	= old.tssload_HDM 	* new.urbhi2011_tss_att_coef,
 	tssload_OtherUp_att 	= old.tssload_OtherUp	* new.all_wetland2011cat_tss_att_coef,
--	tssload_FarmAn_att 	= old.tssload_FarmAn 	* new.all_farm2011cat_tss_att_coef

--	Update based on phone call and email from BME 10.9.18 use tile drain for open space developed
	tssload_tiledrain_att 	= old.tssload_tiledrain * urbop2011_tss_att_coef,

-- Added this 10.2.18 based on conversation with BME
-- Smaller models have lower values for streambank
	tssload_streambank_att 	= (old.tssload_streambank * 1.25) * new.streambnk_tss_att_coef
--	tssload_subsurface_att ,
--	tssload_pointsource_att = old.tssload_pointsource * new.pt_2011_tss_att_coef   ,
--	tssload_septics_att     = old.tssload_septics	* new.lowdensity2011cat_tss_att_coef,
	 
From 
wikiwtershed.huc12_att new
Where old.huc12=new.huc12;

Update huc12_out old
set comid = new.comid
From 
(
Select f.huc12 as huc12, array_agg(t1.comid) as comid
From
	huc12_out f
	join
	wikiwtershed.nhdplus_x_huc12 t1
on f.huc12 = t1.huc12
group by f.huc12
) new	
Where old.huc12 = new.huc12;

set enable_seqscan = on;

Return Query 
Select 
huc12, 
tpload_hp_att,
tpload_Crop_att ,
tpload_Wooded_att ,
tpload_Open_att ,
tpload_barren_att ,
tpload_ldm_att ,
tpload_MDM_att ,
tpload_HDM_att ,
tpload_OtherUp_att ,
tpload_FarmAn_att ,
tpload_tiledrain_att ,
tpload_streambank_att ,
tpload_subsurface_att ,
tpload_pointsource_att ,
tpload_septics_att ,
tnload_hp_att ,
tnload_crop_att ,
tnload_wooded_att ,
tnload_open_att ,
tnload_barren_att ,
tnload_ldm_att ,
tnload_mdm_att ,
tnload_hdm_att ,
tnload_otherup_att ,
tnload_farman_att ,
tnload_tiledrain_att ,
tnload_streambank_att ,
tnload_subsurface_att ,
tnload_pointsource_att ,
tnload_septics_att ,
tssload_hp_att ,
tssload_crop_att ,
tssload_wooded_att ,
tssload_open_att ,
tssload_barren_att ,
tssload_ldm_att ,
tssload_mdm_att ,
tssload_hdm_att ,
tssload_otherup_att ,
tssload_tiledrain_att ,
tssload_streambank_att, 
comid
From huc12_out;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION wikiwtershed.srat_huc12(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[])
  OWNER TO drwiadmin;
GRANT EXECUTE ON FUNCTION wikiwtershed.srat_huc12(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]) TO public;
GRANT EXECUTE ON FUNCTION wikiwtershed.srat_huc12(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]) TO drwiadmin;
GRANT EXECUTE ON FUNCTION wikiwtershed.srat_huc12(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]) TO ms_select;


GRANT EXECUTE ON FUNCTION wikiwtershed.srat_huc12
(
huc12a character varying[],
tpload_hp float [],
tpload_crop float [],
tpload_wooded float [],
tpload_open float [],
tpload_barren float [],
tpload_ldm float [],
tpload_mdm float [],
tpload_hdm float [],
tpload_wetland float [],
tpload_farman float [],
tpload_tiledrain float [],
tpload_streambank float [],
tpload_subsurface float [],
tpload_pointsource float [],
tpload_septics float [],
tnload_hp float [],
tnload_crop float [],
tnload_wooded float [],
tnload_open float [],
tnload_barren float [],
tnload_ldm float [],
tnload_mdm float [],
tnload_hdm float [],
tnload_wetland float [],
tnload_farman float [],
tnload_tiledrain float [],
tnload_streambank float [],
tnload_subsurface float [],
tnload_pointsource float [],
tnload_septics float [],
tssload_hp float [],
tssload_crop float [],
tssload_wooded float [],
tssload_open float [],
tssload_barren float [],
tssload_ldm float [],
tssload_mdm float [],
tssload_hdm float [],
tssload_wetland float [],
tssload_tiledrain float [],
tssload_streambank float []
)

TO ms_select;

SET SESSION AUTHORIZATION 'ms_select';

Select  wikiwtershed.srat_huc12
( array_agg(huc12) 
, array_agg(tmp)  
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)

, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)

, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)

, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)
, array_agg(tmp) 
, array_agg(tmp)

, array_agg(tmp)
)
From
(
Select distinct
huc12, 10 tmp 
From wikiwtershed.cache_nhdcoefs where huc12 like '010400010606'
 
--From wikiwtershed.cache_nhdcoefs where huc12 in  ('010100020101','010100020102','010100020103')
)t  ;




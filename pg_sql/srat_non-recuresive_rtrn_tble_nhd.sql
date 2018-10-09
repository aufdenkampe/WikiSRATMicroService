-- Function: wikiwtershed.srat_nhd(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[])

-- DROP FUNCTION wikiwtershed.srat_nhd(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]);

CREATE OR REPLACE FUNCTION wikiwtershed.srat_nhd(IN huc12a character varying[], IN tpload_hp double precision[], IN tpload_crop double precision[], IN tpload_wooded double precision[], IN tpload_open double precision[], IN tpload_barren double precision[], IN tpload_ldm double precision[], IN tpload_mdm double precision[], IN tpload_hdm double precision[], IN tpload_otherup double precision[], IN tpload_farman double precision[], IN tpload_tiledrain double precision[], IN tpload_streambank double precision[], IN tpload_subsurface double precision[], IN tpload_pointsource double precision[], IN tpload_septics double precision[], IN tnload_hp double precision[], IN tnload_crop double precision[], IN tnload_wooded double precision[], IN tnload_open double precision[], IN tnload_barren double precision[], IN tnload_ldm double precision[], IN tnload_mdm double precision[], IN tnload_hdm double precision[], IN tnload_otherup double precision[], IN tnload_farman double precision[], IN tnload_tiledrain double precision[], IN tnload_streambank double precision[], IN tnload_subsurface double precision[], IN tnload_pointsource double precision[], IN tnload_septics double precision[], IN tssload_hp double precision[], IN tssload_crop double precision[], IN tssload_wooded double precision[], IN tssload_open double precision[], IN tssload_barren double precision[], IN tssload_ldm double precision[], IN tssload_mdm double precision[], IN tssload_hdm double precision[], IN tssload_otherup double precision[], IN tssload_tiledrain double precision[], IN tssload_streambank double precision[])
  RETURNS TABLE(comid2 integer, tploadrate_total2 double precision, tploadrate_conc2 double precision, tnloadrate_total2 double precision, tnloadrate_conc2 double precision, tssloadrate_total2 double precision, tssloadrate_conc2 double precision) AS
$BODY$

BEGIN

Drop Table If Exists nhdplus_out,huc12_out;

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
CONSTRAINT huc12_tmp_primary  PRIMARY KEY (huc12)
) ON COMMIT DROP;


CREATE TEMP TABLE nhdplus_out 
(
comid integer not null,
hydroseq integer not null,
d_comid integer,
ShedAreaDrainLake double precision Default 0,
tploadrate_total  float Default 0,
tploadrate_total_ups  float Default 0,

-- Changed 6-5-18
tp_conc                float Default null,
tnloadrate_total  float Default 0,
tnloadrate_total_ups  float Default 0,

-- Changed 6-5-18
tn_conc                float Default null,
tssloadrate_total  float Default 0,
tssloadrate_total_ups  float Default 0,

-- Changed 6-5-18
tss_conc  float Default null,
totdasqkm float Default 0,
areasqkm float Default 0,
CONSTRAINT nhdplus_tmp_primary PRIMARY KEY (comid)
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

Insert into nhdplus_out 
(
comid
,hydroseq
,d_comid
,ShedAreaDrainLake
,tploadrate_total
,tnloadrate_total
,tssloadrate_total
)
Select 
x.comid
,rte2.hydroseq
,rte1.d_comid
,cfs.ShedAreaDrainLake
,
(
	(              coalesce(huc12_out.tpload_hp,0)          *             coalesce(p_hay2011catcomid_x_huc12,0) ) +
	(              coalesce(huc12_out.tpload_Crop,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_Wooded,0)      *             coalesce(p_all_forest2011cat_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_Open,0)        *             coalesce(p_grs2011catcomid_x_huc12)) +
	(              coalesce(huc12_out.tpload_barren,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)  ) +

	-- Changd based on call with BME 10.9.18
	(              coalesce(huc12_out.tpload_ldm,0)         *             coalesce(p_urbld2011catcomid_x_huc12,0)) +
	
	(              coalesce(huc12_out.tpload_MDM,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_HDM,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_OtherUp,0)     *             coalesce(p_all_wetland2011cat_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_FarmAn,0)      *             coalesce(p_all_farm2011cat_x_huc12,0)) +
	-- Changd based on call with BME 10.9.18
	(              coalesce(huc12_out.tpload_tiledrain,0)   *             coalesce(p_urbop2011catcomid_x_huc12,0)) +

-- Stream Bank Is Special
-- Added this 10.2.18 based on conversation with BME
-- Smaller models have lower values for streambank	
	(              coalesce((huc12_out.tpload_streambank*1.25),0)  *             coalesce(p_catarea_x_huc12,0) * 0.4 ) +
	(              coalesce((huc12_out.tpload_streambank*1.25),0)  *             coalesce(p_imparea_x_huc12,0) * 0.6 ) +
	-- add in 5_22_18
	(              coalesce(huc12_out.tpload_subsurface,0)  *             coalesce(p_tnsumgrnd_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_pointsource,0) *             coalesce(p_pt_kgn_yr_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_septics,0)     *             coalesce(p_all_lowdensity2011cat_x_huc12,0)) 
) *   ( 1 - ( (ShedAreaDrainLake/100) * (select  tp from wikiwtershed.retetion_factors) ))

,
(
	(              coalesce(huc12_out.tnload_hp,0)          *             coalesce(p_hay2011catcomid_x_huc12,0) ) +
	(              coalesce(huc12_out.tnload_Crop,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_Wooded,0)      *             coalesce(p_all_forest2011cat_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_Open,0)        *             coalesce(p_grs2011catcomid_x_huc12)) +
	(              coalesce(huc12_out.tnload_barren,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)  ) +
--	(              coalesce(huc12_out.tnload_ldm,0)         *             coalesce(p_all_lowdensity2011cat_x_huc12,0)) +
-- Changd based on call with BME 10.9.18
	(              coalesce(huc12_out.tnload_ldm,0)         *             coalesce(p_urbld2011catcomid_x_huc12,0)) +
	
	(              coalesce(huc12_out.tnload_MDM,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_HDM,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_OtherUp,0)     *             coalesce(p_all_wetland2011cat_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_FarmAn,0)      *             coalesce(p_all_farm2011cat_x_huc12,0)) +
	-- Changd based on call with BME 10.9.18
	(              coalesce(huc12_out.tnload_tiledrain,0)   *             coalesce(p_urbop2011catcomid_x_huc12,0)) +


-- Stream Bank Is Special
-- Added this 10.2.18 based on conversation with BME
-- Smaller models have lower values for streambank		
	(              coalesce((huc12_out.tnload_streambank*1.25),0)  *             coalesce(p_catarea_x_huc12,0) * 0.4 ) +
	(              coalesce((huc12_out.tnload_streambank*1.25),0)  *             coalesce(p_imparea_x_huc12,0) * 0.6 ) +
	-- add in 5_22_18
	(              coalesce(huc12_out.tnload_subsurface,0)  *             coalesce(p_tnsumgrnd_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_pointsource,0) *             coalesce(p_pt_kgn_yr_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_septics,0)     *             coalesce(p_all_lowdensity2011cat_x_huc12,0)) 
) *   ( 1 - ( (ShedAreaDrainLake/100) * (select  tn from wikiwtershed.retetion_factors) ))


,
(
	(              coalesce(huc12_out.tssload_hp,0)          *             coalesce(p_hay2011catcomid_x_huc12,0) ) +
	(              coalesce(huc12_out.tssload_Crop,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_Wooded,0)      *             coalesce(p_all_forest2011cat_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_Open,0)        *             coalesce(p_grs2011catcomid_x_huc12)) +
	(              coalesce(huc12_out.tssload_barren,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)  ) +
--	(              coalesce(huc12_out.tssload_ldm,0)         *             coalesce(p_all_lowdensity2011cat_x_huc12,0)) +
-- Changd based on call with BME 10.9.18
	(              coalesce(huc12_out.tssload_ldm,0)         *             coalesce(p_urbld2011catcomid_x_huc12,0)) +
		
	(              coalesce(huc12_out.tssload_MDM,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_HDM,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_OtherUp,0)     *             coalesce(p_all_wetland2011cat_x_huc12,0)) +
--	(              coalesce(huc12_out.tssload_FarmAn,0)      *             coalesce(p_all_farm2011cat_x_huc12,0)) +
	--(              coalesce(huc12_out.tssload_tiledrain,0)   *             coalesce(p_catarea_x_huc12,0)) +
	-- Changd based on call with BME 10.9.18
	(              coalesce(huc12_out.tssload_tiledrain,0)   *             coalesce(p_urbop2011catcomid_x_huc12,0)) +
	

-- Stream Bank Is Special
-- Added this 10.2.18 based on conversation with BME
-- Smaller models have lower values for streambank		
	(              coalesce((huc12_out.tssload_streambank*1.25),0)  *             coalesce(p_catarea_x_huc12,0) * 0.4 ) +
	(              coalesce((huc12_out.tssload_streambank*1.25),0)  *             coalesce(p_imparea_x_huc12,0) * 0.6 ) 
	--(              coalesce(huc12_out.tssload_subsurface,0)  *             coalesce(p_catarea_x_huc12,0)) +
	--(              coalesce(huc12_out.tssload_pointsource,0) *             coalesce(p_catarea_x_huc12,0)) +
	--(              coalesce(huc12_out.tssload_septics,0)     *             coalesce(p_catarea_x_huc12,0)) 
) *   ( 1 - ( (ShedAreaDrainLake/100) * (select  tss from wikiwtershed.retetion_factors) ))

From 
                wikiwtershed.nhdplus_x_huc12 x 
                
                join 
                huc12_out 
                on x.huc12 = huc12_out.huc12
                
                join
                wikiwtershed.cache_nhdcoefs cfs
                on x.comid = cfs.comid

                join
                wikiwtershed.comid_routing rte1
                ON x.comid=rte1.comid
                
                join
                wikiwtershed.nhdplus_stream_nsidx rte2
                ON x.comid=rte2.comid;



-- Set the upstream equal to the total before you start


update nhdplus_out 
set 
	tnloadrate_total_ups = tnloadrate_total,
	tploadrate_total_ups = tploadrate_total,
	tssloadrate_total_ups = tssloadrate_total;


Update nhdplus_out as old
Set   
     areasqkm 	= new.areasqkm
From wikiwtershed.nhdplus_stream_nsidx new
where old.comid = new.comid;
-- Push It Down the tree for every Row..
--

Update nhdplus_out as old
Set   
     totdasqkm 	= new.totdasqkm
From wikiwtershed.nhdplus_totdasqkm new
where old.comid = new.comid;
-- Push It Down the tree for every Row..
--


 
do 
$$ 
declare _r record; 
begin 
  for _r in ( select * from nhdplus_out order by hydroseq desc ) loop
    -- Push Down  
    Update nhdplus_out old
	Set 
		 tnloadrate_total_ups = (  tnloadrate_total_ups + Coalesce( tn_plus,0) )
		,tploadrate_total_ups = (  tploadrate_total_ups + Coalesce( tp_plus,0) )
		,tssloadrate_total_ups= ( tssloadrate_total_ups + Coalesce(tss_plus,0) )
		,areasqkm	  = old.areasqkm + new.areasqkm
    From ( 
		Select 
			 tnloadrate_total_ups  * (1 - ( (ShedAreaDrainLake/100) * (select  tn from wikiwtershed.retetion_factors) )) as tn_plus
			,tploadrate_total_ups  * (1 - ( (ShedAreaDrainLake/100) * (select  tp from wikiwtershed.retetion_factors) )) as tp_plus
			,tssloadrate_total_ups * (1 - ( (ShedAreaDrainLake/100) * (select tss from wikiwtershed.retetion_factors) )) as tss_plus
	                ,areasqkm
		From nhdplus_out 
		where comid = _r.comid
	 ) new
    Where old.comid = _r.d_comid; 

    
  end loop; 
end; 
$$
;
 

-- convert to cubic feet multiple times seconds in a year
-- 31557600 (365.25*24*60*60)
-- 28.3168 liters in a cubic foot
-- 1000000 mg in kg

Update 
	nhdplus_out old
	Set 
		
		tp_conc  = ( tploadrate_total_ups  * 1000000 ) / ( new.qe_ma * 31557600 * 28.3168 ),
		tn_conc  = ( tnloadrate_total_ups  * 1000000 ) / ( new.qe_ma * 31557600 * 28.3168 ),
		tss_conc = ( tssloadrate_total_ups * 1000000 ) / ( new.qe_ma * 31557600 * 28.3168 )
From wikiwtershed.cache_nhdcoefs new
Where new.comid = old.comid 
	And
		--( totdasqkm between (areasqkm * 0.95) And (areasqkm * 1.05) )
		( totdasqkm > (areasqkm * 0.95)) And ( totdasqkm < (areasqkm * 1.05)) 
	And
		new.qe_ma > 0;
		-- This gives us a 5 percent fudge factor on the upstream s
set enable_seqscan = on;

-- Check values For Area

Return Query 
Select 
	comid, 
	tploadrate_total,  tp_conc, 
	--totdasqkm, areasqkm,
	
	tnloadrate_total,  tn_conc, 
	tssloadrate_total, tss_conc 
From nhdplus_out;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100
  ROWS 1000;
ALTER FUNCTION wikiwtershed.srat_nhd(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[])
  OWNER TO drwiadmin;
GRANT EXECUTE ON FUNCTION wikiwtershed.srat_nhd(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]) TO public;
GRANT EXECUTE ON FUNCTION wikiwtershed.srat_nhd(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]) TO drwiadmin;
GRANT EXECUTE ON FUNCTION wikiwtershed.srat_nhd(character varying[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[], double precision[]) TO ms_select;

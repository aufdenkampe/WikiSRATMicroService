
-- Function: wikiwtershed.srat_strmbank(character varying[], double precision[])
-- To Do Calculate total sum for each reach


-- DROP FUNCTION wikiwtershed.srat_tst(character varying[]);

CREATE OR REPLACE FUNCTION wikiwtershed.srat_nhd
(
huc12a character varying[],
tpload_hp float [],
tpload_Crop float [],
tpload_Wooded float [],
tpload_Open float [],
tpload_barren float [],
tpload_ldm float [],
tpload_MDM float [],
tpload_HDM float [],
tpload_OtherUp float [],
tpload_FarmAn float [],
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


)
  RETURNS TABLE(
	comid int, 
	tploadrate_total float, tploadrate_conc float, 
	tnloadrate_total float, tnloadrate_conc float, 
	tssloadrate_total float, tssloadrate_conc float
  ) AS
$BODY$
Declare varout text;

--Declare _tn_coef double precision;
--Declare _tp_coef double precision;
--Declare _tss_coef double precision;	

BEGIN

--_tn_coef := (select tn from wikiwtershed.retetion_factors);
--_tp_coef := (select tp from wikiwtershed.retetion_factors);
--_tss_coef := (select tss from wikiwtershed.retetion_factors);


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
dnhydroseq integer not null,
ShedAreaDrainLake double precision Default 0,
tploadrate_total  float Default 0,
tploadrate_total_ups  float Default 0,
tp_conc                float Default 0,
tnloadrate_total  float Default 0,
tnloadrate_total_ups  float Default 0,
tn_conc                float Default 0,
tssloadrate_total  float Default 0,
tssloadrate_total_ups  float Default 0,
tss_conc  float Default 0,
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
,dnhydroseq
,ShedAreaDrainLake
,tploadrate_total
,tnloadrate_total
,tssloadrate_total
)
Select 
x.comid
,rte.hydroseq
,rte.dnhydroseq 
,cfs.ShedAreaDrainLake
,(
	(              coalesce(huc12_out.tpload_hp,0)          *             coalesce(p_hay2011catcomid_x_huc12,0) ) +
	(              coalesce(huc12_out.tpload_Crop,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_Wooded,0)      *             (  p_decid2011catcomid_x_huc12  +   p_conif2011catcomid_x_huc12)) +
	(              coalesce(huc12_out.tpload_Open,0)        *             coalesce(p_catarea_x_huc12)) +
	(              coalesce(huc12_out.tpload_barren,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)  ) +
	(              coalesce(huc12_out.tpload_ldm,0)         *             coalesce(p_urblo2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_MDM,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_HDM,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_OtherUp,0)     *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_FarmAn,0)      *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_tiledrain,0)   *             coalesce(p_catarea_x_huc12,0)) +

-- Stream Bank Is Special	
	(              coalesce(huc12_out.tpload_streambank,0)  *             coalesce(p_catarea_x_huc12,0) * 0.4 ) +
	(              coalesce(huc12_out.tpload_streambank,0)  *             coalesce(p_imparea_x_huc12,0) * 0.6 ) +
	
	(              coalesce(huc12_out.tpload_subsurface,0)  *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_pointsource,0) *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tpload_septics,0)     *             coalesce(p_catarea_x_huc12,0)) 
 ) *   ( 1 - ( ShedAreaDrainLake * (select  tp from wikiwtershed.retetion_factors) ))
 

,
(
	(              coalesce(huc12_out.tnload_hp,0)          *             coalesce(p_hay2011catcomid_x_huc12,0) ) +
	(              coalesce(huc12_out.tnload_Crop,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_Wooded,0)      *             (  p_decid2011catcomid_x_huc12  +   p_conif2011catcomid_x_huc12)) +
	(              coalesce(huc12_out.tnload_Open,0)        *             coalesce(p_catarea_x_huc12)) +
	(              coalesce(huc12_out.tnload_barren,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)  ) +
	(              coalesce(huc12_out.tnload_ldm,0)         *             coalesce(p_urblo2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_MDM,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_HDM,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_OtherUp,0)     *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_FarmAn,0)      *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_tiledrain,0)   *             coalesce(p_catarea_x_huc12,0)) +

-- Stream Bank Is Special	
	(              coalesce(huc12_out.tnload_streambank,0)  *             coalesce(p_catarea_x_huc12,0) * 0.4 ) +
	(              coalesce(huc12_out.tnload_streambank,0)  *             coalesce(p_imparea_x_huc12,0) * 0.6 ) +
	
	(              coalesce(huc12_out.tnload_subsurface,0)  *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_pointsource,0) *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tnload_septics,0)     *             coalesce(p_catarea_x_huc12,0)) 
) *   ( 1 - ( ShedAreaDrainLake * (select  tn from wikiwtershed.retetion_factors) ))


,
(
	(              coalesce(huc12_out.tssload_hp,0)          *             coalesce(p_hay2011catcomid_x_huc12,0) ) +
	(              coalesce(huc12_out.tssload_Crop,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_Wooded,0)      *             (  p_decid2011catcomid_x_huc12  +   p_conif2011catcomid_x_huc12)) +
	(              coalesce(huc12_out.tssload_Open,0)        *             coalesce(p_catarea_x_huc12)) +
	(              coalesce(huc12_out.tssload_barren,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)  ) +
	(              coalesce(huc12_out.tssload_ldm,0)         *             coalesce(p_urblo2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_MDM,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_HDM,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_OtherUp,0)     *             coalesce(p_catarea_x_huc12,0)) +
	--(              coalesce(huc12_out.tssload_FarmAn,0)      *             coalesce(p_catarea_x_huc12,0)) +
	(              coalesce(huc12_out.tssload_tiledrain,0)   *             coalesce(p_catarea_x_huc12,0)) +
	
-- Stream Bank Is Special	
	(              coalesce(huc12_out.tssload_streambank,0)  *             coalesce(p_catarea_x_huc12,0) * 0.4 ) +
	(              coalesce(huc12_out.tssload_streambank,0)  *             coalesce(p_imparea_x_huc12,0) * 0.6 )  
	--(              coalesce(huc12_out.tssload_subsurface,0)  *             coalesce(p_catarea_x_huc12,0)) +
	--(              coalesce(huc12_out.tssload_pointsource,0) *             coalesce(p_catarea_x_huc12,0)) +
	--(              coalesce(huc12_out.tssload_septics,0)     *             coalesce(p_catarea_x_huc12,0)) 
) *   ( 1 - ( ShedAreaDrainLake * (select  tss from wikiwtershed.retetion_factors) ))

 

From 
                wikiwtershed.nhdplus_x_huc12 x 
                join 
                huc12_out 
                on x.huc12 = huc12_out.huc12
                join
                wikiwtershed.cache_nhdcoefs cfs
                on x.comid = cfs.comid
                join
                wikiwtershed.nhdplus_stream_nsidx rte
                ON x.comid=rte.comid
                ;


-- Push It Down


do 
$$ 
declare _r record; 
begin 
  for _r in ( select * from nhdplus_out order by hydroseq asc) loop
    -- Push Down  
    Update nhdplus_out old
	Set 
		 tnloadrate_total = (  tnloadrate_total + Coalesce( tn_plus,0) )
		,tploadrate_total = (  tploadrate_total + Coalesce( tp_plus,0) )
		,tssloadrate_total= ( tssloadrate_total + Coalesce(tss_plus,0) )
    From ( 
		Select 
			 tnloadrate_total  * (1 - ( ShedAreaDrainLake * (select  tn from wikiwtershed.retetion_factors) )) as tn_plus
			,tploadrate_total  * (1 - ( ShedAreaDrainLake * (select  tp from wikiwtershed.retetion_factors) )) as tp_plus
			,tssloadrate_total * (1 - ( ShedAreaDrainLake * (select tss from wikiwtershed.retetion_factors) )) as tss_plus
	 
		From nhdplus_out 
		where comid = _r.comid
	 ) new
    Where old.hydroseq = _r.dnhydroseq; 

    
  end loop; 
end; 
$$
;
 
set enable_seqscan = on;

Select 
	comid, 
	tploadrate_total,  tploadrate_conc, 
	tnloadrate_total,  tnloadrate_conc, 
	tssloadrate_total, tssloadrate_conc 
From nhdplus_out;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



GRANT EXECUTE ON FUNCTION wikiwtershed.srat_nhd
(
huc12a character varying[],
tpload_hp float [],
tpload_Crop float [],
tpload_Wooded float [],
tpload_Open float [],
tpload_barren float [],
tpload_ldm float [],
tpload_MDM float [],
tpload_HDM float [],
tpload_OtherUp float [],
tpload_FarmAn float [],
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
)

TO ms_select;

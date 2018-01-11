
-- Function: wikiwtershed.srat_strmbank(character varying[], double precision[])
-- To Do Calculate total sum for each reach


-- DROP FUNCTION wikiwtershed.srat_tst(character varying[]);

CREATE OR REPLACE FUNCTION wikiwtershed.srat_tst
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
  RETURNS text AS
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
Select 
unnest(huc12a) as huc12a, 
unnest(tpload_hp),
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
 ) *   ( 1 - ( (ShedAreaDrainLake/100) * (select  tp from wikiwtershed.retetion_factors) ))
 

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
) *   ( 1 - ( (ShedAreaDrainLake/100) * (select  tn from wikiwtershed.retetion_factors) ))


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

			--0 as tn_plus,0 as tp_plus, 0 as tss_plus	
			 tnloadrate_total  * (1 - ( (ShedAreaDrainLake/100) * (select  tn from wikiwtershed.retetion_factors) )) as tn_plus
			 ,tploadrate_total  * (1 - ( (ShedAreaDrainLake/100) * (select  tp from wikiwtershed.retetion_factors) )) as tp_plus
			 ,tssloadrate_total * (1 - ( (ShedAreaDrainLake/100) * (select tss from wikiwtershed.retetion_factors) )) as tss_plus
	 
		From nhdplus_out 
		where comid = _r.comid
	 ) new
    Where old.hydroseq = _r.dnhydroseq; 

    
  end loop; 
end; 
$$
;
 

set enable_seqscan = on;


varout := 
(	(Select '{{huc12'::text)
	|| (Select array_agg(huc12)::text from huc12_out)

	|| (Select '{ tpload_hp_att' || array_agg(tpload_hp_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_Crop_att ' || array_agg(tpload_Crop_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_Wooded_att ' || array_agg(tpload_Wooded_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_Open_att ' || array_agg(tpload_Open_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_barren_att ' || array_agg(tpload_barren_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_ldm_att ' || array_agg(tpload_ldm_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_MDM_att ' || array_agg(tpload_MDM_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_HDM_att ' || array_agg(tpload_HDM_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_OtherUp_att ' || array_agg(tpload_OtherUp_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_FarmAn_att ' || array_agg(tpload_FarmAn_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_tiledrain_att ' || array_agg(tpload_tiledrain_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_streambank_att ' || array_agg(tpload_streambank_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_subsurface_att ' || array_agg(tpload_subsurface_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_pointsource_att ' || array_agg(tpload_pointsource_att)::text || '}' from huc12_out)
	|| (Select '{ tpload_septics_att ' || array_agg(tpload_septics_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_hp_att ' || array_agg(tnload_hp_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_crop_att ' || array_agg(tnload_crop_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_wooded_att ' || array_agg(tnload_wooded_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_open_att ' || array_agg(tnload_open_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_barren_att ' || array_agg(tnload_barren_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_ldm_att ' || array_agg(tnload_ldm_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_mdm_att ' || array_agg(tnload_mdm_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_hdm_att ' || array_agg(tnload_hdm_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_otherup_att ' || array_agg(tnload_otherup_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_farman_att ' || array_agg(tnload_farman_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_tiledrain_att ' || array_agg(tnload_tiledrain_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_streambank_att ' || array_agg(tnload_streambank_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_subsurface_att ' || array_agg(tnload_subsurface_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_pointsource_att ' || array_agg(tnload_pointsource_att)::text || '}' from huc12_out)
	|| (Select '{ tnload_septics_att ' || array_agg(tnload_septics_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_hp_att ' || array_agg(tssload_hp_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_crop_att ' || array_agg(tssload_crop_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_wooded_att ' || array_agg(tssload_wooded_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_open_att ' || array_agg(tssload_open_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_barren_att ' || array_agg(tssload_barren_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_ldm_att ' || array_agg(tssload_ldm_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_mdm_att ' || array_agg(tssload_mdm_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_hdm_att ' || array_agg(tssload_hdm_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_otherup_att ' || array_agg(tssload_otherup_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_tiledrain_att ' || array_agg(tssload_tiledrain_att)::text || '}' from huc12_out)
	|| (Select '{ tssload_streambank_att ' || array_agg(tssload_streambank_att)::text || '}' from huc12_out)

	|| (Select '}{comid'::text)
	|| (Select array_agg(comid)::text from nhdplus_out)

	|| (Select '{tploadrate_total  ' || array_agg(tploadrate_total)::text || '}' from nhdplus_out)
	|| (Select '{tp_conc' || array_agg(tp_conc)::text || '}' from nhdplus_out)
	
	|| (Select '{tnloadrate_total' || array_agg(tnloadrate_total)::text || '}' from nhdplus_out)
	|| (Select '{tn_conc' || array_agg(tn_conc)::text || '}' from nhdplus_out)
 
	|| (Select '{tssloadrate_total' || array_agg(tssloadrate_total)::text || '}' from nhdplus_out)
	|| (Select '{tss_conc' || array_agg(tss_conc)::text || '}' from nhdplus_out)
	||(Select '}}'::text )
);

varout := ( Select replace(varout, '{', '('));
varout := ( Select replace(varout, '}', ')'));

RETURN varout;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;



GRANT EXECUTE ON FUNCTION wikiwtershed.srat_tst
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

Select wikiwtershed.srat_tst
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
From wikiwtershed.cache_nhdcoefs where huc12 like '020402%'
Limit 10
--From wikiwtershed.cache_nhdcoefs where huc12 in  ('010100020101','010100020102','010100020103')
)t  ;



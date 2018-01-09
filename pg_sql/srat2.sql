
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
BEGIN

Drop Table If Exists nhdplus_out,huc12_out;

-- Create Temporary Output Tables 
CREATE TEMP TABLE huc12_out 
(
huc12 character varying(12)not null,
tpload_hp_att float Default 0,
tpload_Crop_att  float Default 0 ,
tpload_Wooded_att  float Default 0 ,
tpload_Open_att  float Default 0 ,
tpload_barren_att  float Default 0 ,
tpload_ldm_att  float Default 0 ,
tpload_MDM_att  float Default 0 ,
tpload_HDM_att  float Default 0 ,
tpload_OtherUp_att  float Default 0 ,
tpload_FarmAn_att  float Default 0 ,
tpload_tiledrain_att  float Default 0 ,
tpload_streambank_att  float Default 0 ,
tpload_subsurface_att  float Default 0 ,
tpload_pointsource_att  float Default 0 ,
tpload_septics_att  float Default 0 ,
tnload_hp_att  float Default 0 ,
tnload_crop_att  float Default 0 ,
tnload_wooded_att  float Default 0 ,
tnload_open_att  float Default 0 ,
tnload_barren_att  float Default 0 ,
tnload_ldm_att  float Default 0 ,
tnload_mdm_att  float Default 0 ,
tnload_hdm_att  float Default 0 ,
tnload_otherup_att  float Default 0 ,
tnload_farman_att  float Default 0 ,
tnload_tiledrain_att  float Default 0 ,
tnload_streambank_att  float Default 0 ,
tnload_subsurface_att  float Default 0 ,
tnload_pointsource_att  float Default 0 ,
tnload_septics_att  float Default 0 ,
tssload_hp_att  float Default 0 ,
tssload_crop_att  float Default 0 ,
tssload_wooded_att  float Default 0 ,
tssload_open_att  float Default 0 ,
tssload_barren_att  float Default 0 ,
tssload_ldm_att  float Default 0 ,
tssload_mdm_att  float Default 0 ,
tssload_hdm_att  float Default 0 ,
tssload_otherup_att  float Default 0 ,
tssload_tiledrain_att  float Default 0 ,
tssload_streambank_att  float Default 0 ,
CONSTRAINT huc12_tmp_primary  PRIMARY KEY (huc12)
) ON COMMIT DROP;







CREATE TEMP TABLE nhdplus_out 
(
comid integer not null,
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
tpload_hp_att   ,
tpload_Crop_att              ,
tpload_Wooded_att      ,
tpload_Open_att             ,
tpload_barren_att          ,
tpload_ldm_att                ,
tpload_MDM_att            ,
tpload_HDM_att              ,
tpload_OtherUp_att      ,
tpload_FarmAn_att        ,
tpload_tiledrain_att       ,
tpload_streambank_att                ,
tpload_subsurface_att                  ,
tpload_pointsource_att                ,
tpload_septics_att          ,
tnload_hp_att                   ,
tnload_crop_att               ,
tnload_wooded_att       ,
tnload_open_att             ,
tnload_barren_att          ,
tnload_ldm_att                ,
tnload_mdm_att             ,
tnload_hdm_att               ,
tnload_otherup_att       ,
tnload_farman_att         ,
tnload_tiledrain_att       ,
tnload_streambank_att                ,
tnload_subsurface_att                  ,
tnload_pointsource_att                ,
tnload_septics_att          ,
tssload_hp_att                 ,
tssload_crop_att              ,
tssload_wooded_att      ,
tssload_open_att            ,
tssload_barren_att         ,
tssload_ldm_att               ,
tssload_mdm_att            ,
tssload_hdm_att             ,
tssload_otherup_att      ,
tssload_tiledrain_att      ,
tssload_streambank_att

)
Select unnest(huc12a) as huc12a, 
unnest(                tpload_hp           )              ,
unnest(                tpload_Crop       )              ,
unnest(                tpload_Wooded               )              ,
unnest(                tpload_Open     )              ,
unnest(                tpload_barren   )              ,
unnest(                tpload_ldm         )              ,
unnest(                tpload_MDM     )              ,
unnest(                tpload_HDM      )              ,
unnest(                tpload_OtherUp              )              ,
unnest(                tpload_FarmAn )              ,
unnest(                tpload_tiledrain                )              ,
unnest(                tpload_streambank        )              ,
unnest(                tpload_subsurface          )              ,
unnest(                tpload_pointsource        )              ,
unnest(                tpload_septics  )              ,
unnest(                tnload_hp           )              ,
unnest(                tnload_crop       )              ,
unnest(                tnload_wooded               )              ,
unnest(                tnload_open      )              ,
unnest(                tnload_barren   )              ,
unnest(                tnload_ldm         )              ,
unnest(                tnload_mdm      )              ,
unnest(                tnload_hdm       )              ,
unnest(                tnload_otherup                )              ,
unnest(                tnload_farman  )              ,
unnest(                tnload_tiledrain                )              ,
unnest(                tnload_streambank        )              ,
unnest(                tnload_subsurface          )              ,
unnest(                tnload_pointsource        )              ,
unnest(                tnload_septics  )              ,
unnest(                tssload_hp          )              ,
unnest(                tssload_crop      )              ,
unnest(                tssload_wooded              )              ,
unnest(                tssload_open    )              ,
unnest(                tssload_barren )              ,
unnest(                tssload_ldm       )              ,
unnest(                tssload_mdm    )              ,
unnest(                tssload_hdm      )              ,
unnest(                tssload_otherup              )              ,
unnest(                tssload_tiledrain              )              ,
unnest(                tssload_streambank       )
;

Insert into nhdplus_out 
(
comid,
tploadrate_total
,tnloadrate_total
,tssloadrate_total
)
Select 
x.comid 
,
(
	(              coalesce(tpload_hp_att,0)          *             coalesce(p_hay2011catcomid_x_huc12,0)       ) +
	(              coalesce(tpload_Crop_att,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)      ) +
	(              coalesce(tpload_Wooded_att,0)      *             (  p_decid2011catcomid_x_huc12  +   p_conif2011catcomid_x_huc12  ) ) +
	(              coalesce(tpload_Open_att,0)        *             coalesce(p_catarea_x_huc12)                 ) +
	(              coalesce(tpload_barren_att,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)        ) +
	(              coalesce(tpload_ldm_att,0)         *             coalesce(p_urblo2011catcomid_x_huc12,0)     ) +
	(              coalesce(tpload_MDM_att,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)     ) +
	(              coalesce(tpload_HDM_att,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)     ) +
	(              coalesce(tpload_OtherUp_att,0)     *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tpload_FarmAn_att,0)      *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tpload_tiledrain_att,0)   *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tpload_streambank_att,0)  *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tpload_subsurface_att,0)  *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tpload_pointsource_att,0) *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tpload_septics_att,0)     *             coalesce(p_catarea_x_huc12,0)               ) 
)
 

,
(
	(              coalesce(tnload_hp_att,0)          *             coalesce(p_hay2011catcomid_x_huc12,0)       ) +
	(              coalesce(tnload_Crop_att,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)      ) +
	(              coalesce(tnload_Wooded_att,0)      *             (  p_decid2011catcomid_x_huc12  +   p_conif2011catcomid_x_huc12  ) ) +
	(              coalesce(tnload_Open_att,0)        *             coalesce(p_catarea_x_huc12)                 ) +
	(              coalesce(tnload_barren_att,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)        ) +
	(              coalesce(tnload_ldm_att,0)         *             coalesce(p_urblo2011catcomid_x_huc12,0)     ) +
	(              coalesce(tnload_MDM_att,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)     ) +
	(              coalesce(tnload_HDM_att,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)     ) +
	(              coalesce(tnload_OtherUp_att,0)     *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tnload_FarmAn_att,0)      *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tnload_tiledrain_att,0)   *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tnload_streambank_att,0)  *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tnload_subsurface_att,0)  *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tnload_pointsource_att,0) *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tnload_septics_att,0)     *             coalesce(p_catarea_x_huc12,0)               ) 
)

,
(
	(              coalesce(tssload_hp_att,0)          *             coalesce(p_hay2011catcomid_x_huc12,0)       ) +
	(              coalesce(tssload_Crop_att,0)        *             coalesce(p_crop2011catcomid_x_huc12,0)      ) +
	(              coalesce(tssload_Wooded_att,0)      *             (  p_decid2011catcomid_x_huc12  +   p_conif2011catcomid_x_huc12  ) ) +
	(              coalesce(tssload_Open_att,0)        *             coalesce(p_catarea_x_huc12)                 ) +
	(              coalesce(tssload_barren_att,0)      *             coalesce(p_bl2011catcomid_x_huc12,0)        ) +
	(              coalesce(tssload_ldm_att,0)         *             coalesce(p_urblo2011catcomid_x_huc12,0)     ) +
	(              coalesce(tssload_MDM_att,0)         *             coalesce(p_urbmd2011catcomid_x_huc12,0)     ) +
	(              coalesce(tssload_HDM_att,0)         *             coalesce(p_urbhi2011catcomid_x_huc12,0)     ) +
	(              coalesce(tssload_OtherUp_att,0)     *             coalesce(p_catarea_x_huc12,0)               ) +
	--(              coalesce(tssload_FarmAn_att,0)      *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tssload_tiledrain_att,0)   *             coalesce(p_catarea_x_huc12,0)               ) +
	(              coalesce(tssload_streambank_att,0)  *             coalesce(p_catarea_x_huc12,0)               ) 
	--(              coalesce(tssload_subsurface_att,0)  *             coalesce(p_catarea_x_huc12,0)               ) +
	--(              coalesce(tssload_pointsource_att,0) *             coalesce(p_catarea_x_huc12,0)               ) +
	--(              coalesce(tssload_septics_att,0)     *             coalesce(p_catarea_x_huc12,0)               ) 
)
 

From 
                wikiwtershed.nhdplus_x_huc12 x 
                join 
                huc12_out 
                on x.huc12 = huc12_out.huc12
                join
                wikiwtershed.cache_nhdcoefs cfs
                on x.comid = cfs.comid;




-- SUM ALL ABOVE

Update nhdplus_out old
set 
	tploadrate_total_ups  = out_tp
	,tnloadrate_total_ups  = out_tn  
From 
(
With Recursive included_parts(comid, hydroseq, tploadrate_total, tnloadrate_total) As 
(
Select comid, hydroseq ,tploadrate_total, tnloadrate_total  
From  (
      Select lnx.comid, lnx.hydroseq, filter.tploadrate_total, filter.tnloadrate_total
      From wikiwtershed.nhdplus_stream_nsidx lnx join nhdplus_out filter
      On lnx.comid = filter.comid
      ) t
Union All

Select included_parts.comid, t1.hydroseq ,t1.tploadrate_total, t1.tnloadrate_total
From  (
      Select lnx.comid, lnx.hydroseq, lnx.dnhydroseq, filter.tploadrate_total, filter.tnloadrate_total
      From wikiwtershed.nhdplus_stream_nsidx lnx join nhdplus_out filter
      On lnx.comid = filter.comid
      ) t1 
join included_parts 
on t1.dnhydroseq = included_parts.hydroseq  
)
Select 
	comid
	,sum(tploadrate_total) out_tp
	,sum(tploadrate_total) out_tn
From included_parts group by comid 
) new
Where new.comid = old.comid ;


--Calc local Loading
--comid (nhdplus)            integer na
--             float       kg/acre avg yr
--tp_conc            float       kg/acre avg yr
--tnloadrate_total           float       kg/acre avg yr
--tn_conc            float       kg/acre avg yr
--tssloadrate_total          float       kg/acre avg yr
--tss_conc           float       kg/acre avg yr



--Create temp table coefs  as 
--(
--Select comid, p_crop2011catcomid_x_huc12 * inputs.tpdec as v_crop2011catcomid 
--From wikiwtershed.cache_nhdcoefs x join inputs on x.huc12 = inputs.huc12a -
--);

set enable_seqscan = on;

RETURN 
( 
(Select '{{huc12'::text)
|| (Select array_agg(huc12)::text from huc12_out)

|| (Select '{ tpload_hp_att' || array_agg(tpload_hp_att)::text || '}' from huc12_out)
|| (Select '{ tpload_Crop_att ' || array_agg(tpload_Crop_att )::text || '}' from huc12_out)
|| (Select '{ tpload_Wooded_att ' || array_agg(tpload_Wooded_att )::text || '}' from huc12_out)
|| (Select '{ tpload_Open_att ' || array_agg(tpload_Open_att )::text || '}' from huc12_out)
|| (Select '{ tpload_barren_att ' || array_agg(tpload_barren_att )::text || '}' from huc12_out)
|| (Select '{ tpload_ldm_att ' || array_agg(tpload_ldm_att )::text || '}' from huc12_out)
|| (Select '{ tpload_MDM_att ' || array_agg(tpload_MDM_att )::text || '}' from huc12_out)
|| (Select '{ tpload_HDM_att ' || array_agg(tpload_HDM_att )::text || '}' from huc12_out)
|| (Select '{ tpload_OtherUp_att ' || array_agg(tpload_OtherUp_att )::text || '}' from huc12_out)
|| (Select '{ tpload_FarmAn_att ' || array_agg(tpload_FarmAn_att )::text || '}' from huc12_out)
|| (Select '{ tpload_tiledrain_att ' || array_agg(tpload_tiledrain_att )::text || '}' from huc12_out)
|| (Select '{ tpload_streambank_att ' || array_agg(tpload_streambank_att )::text || '}' from huc12_out)
|| (Select '{ tpload_subsurface_att ' || array_agg(tpload_subsurface_att )::text || '}' from huc12_out)
|| (Select '{ tpload_pointsource_att ' || array_agg(tpload_pointsource_att )::text || '}' from huc12_out)
|| (Select '{ tpload_septics_att ' || array_agg(tpload_septics_att )::text || '}' from huc12_out)
|| (Select '{ tnload_hp_att ' || array_agg(tnload_hp_att )::text || '}' from huc12_out)
|| (Select '{ tnload_crop_att ' || array_agg(tnload_crop_att )::text || '}' from huc12_out)
|| (Select '{ tnload_wooded_att ' || array_agg(tnload_wooded_att )::text || '}' from huc12_out)
|| (Select '{ tnload_open_att ' || array_agg(tnload_open_att )::text || '}' from huc12_out)
|| (Select '{ tnload_barren_att ' || array_agg(tnload_barren_att )::text || '}' from huc12_out)
|| (Select '{ tnload_ldm_att ' || array_agg(tnload_ldm_att )::text || '}' from huc12_out)
|| (Select '{ tnload_mdm_att ' || array_agg(tnload_mdm_att )::text || '}' from huc12_out)
|| (Select '{ tnload_hdm_att ' || array_agg(tnload_hdm_att )::text || '}' from huc12_out)
|| (Select '{ tnload_otherup_att ' || array_agg(tnload_otherup_att )::text || '}' from huc12_out)
|| (Select '{ tnload_farman_att ' || array_agg(tnload_farman_att )::text || '}' from huc12_out)
|| (Select '{ tnload_tiledrain_att ' || array_agg(tnload_tiledrain_att )::text || '}' from huc12_out)
|| (Select '{ tnload_streambank_att ' || array_agg(tnload_streambank_att )::text || '}' from huc12_out)
|| (Select '{ tnload_subsurface_att ' || array_agg(tnload_subsurface_att )::text || '}' from huc12_out)
|| (Select '{ tnload_pointsource_att ' || array_agg(tnload_pointsource_att )::text || '}' from huc12_out)
|| (Select '{ tnload_septics_att ' || array_agg(tnload_septics_att )::text || '}' from huc12_out)
|| (Select '{ tssload_hp_att ' || array_agg(tssload_hp_att )::text || '}' from huc12_out)
|| (Select '{ tssload_crop_att ' || array_agg(tssload_crop_att )::text || '}' from huc12_out)
|| (Select '{ tssload_wooded_att ' || array_agg(tssload_wooded_att )::text || '}' from huc12_out)
|| (Select '{ tssload_open_att ' || array_agg(tssload_open_att )::text || '}' from huc12_out)
|| (Select '{ tssload_barren_att ' || array_agg(tssload_barren_att )::text || '}' from huc12_out)
|| (Select '{ tssload_ldm_att ' || array_agg(tssload_ldm_att )::text || '}' from huc12_out)
|| (Select '{ tssload_mdm_att ' || array_agg(tssload_mdm_att )::text || '}' from huc12_out)
|| (Select '{ tssload_hdm_att ' || array_agg(tssload_hdm_att )::text || '}' from huc12_out)
|| (Select '{ tssload_otherup_att ' || array_agg(tssload_otherup_att )::text || '}' from huc12_out)
|| (Select '{ tssload_tiledrain_att ' || array_agg(tssload_tiledrain_att )::text || '}' from huc12_out)
|| (Select '{ tssload_streambank_att ' || array_agg(tssload_streambank_att )::text || '}' from huc12_out)


|| (Select '}{comid'::text )
|| (Select array_agg(comid)::text from nhdplus_out)

|| (Select '{ tploadrate_total  ' || array_agg(tploadrate_total  )::text || '}' from nhdplus_out)
|| (Select '{ tploadrate_total  ' || array_agg(tploadrate_total_ups  )::text || '}' from nhdplus_out)
|| (Select '{ tp_conc' || array_agg(tp_conc)::text || '}' from nhdplus_out)
|| (Select '{ tnloadrate_total' || array_agg(tnloadrate_total)::text || '}' from nhdplus_out)
|| (Select '{ tn_conc' || array_agg(tn_conc)::text || '}' from nhdplus_out)
|| (Select '{ tssloadrate_total' || array_agg(tssloadrate_total)::text || '}' from nhdplus_out)
|| (Select '{ tss_conc' || array_agg(tss_conc)::text || '}' from nhdplus_out)
||(Select '}}'::text )

);

Drop Table If Exists nhdplus_out,huc12_out;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION  wikiwtershed.srat_tst(character varying[])
  OWNER TO drwiadmin;

 

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
From wikiwtershed.cache_nhdcoefs where huc12 in  ('010100020101','010100020102','010100020103')
)t  ;



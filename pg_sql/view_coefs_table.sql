-- View: wikiwtershed.nhdcoefs

-- DROP VIEW wikiwtershed.nhdcoefs;

CREATE OR REPLACE VIEW wikiwtershed.nhdcoefs AS 
 WITH tmp AS (
         SELECT t1.comid, t2.huc12, COALESCE(nut.tnsumgrnd, 0::double precision) AS tnsumgrnd, t1.catareasqkm, t1.wsareasqkm, t1.catpctfull, t1.wspctfull, COALESCE(t1.pctow2011cat, 0::double precision) + COALESCE(t1.pctwdwet2011cat, 0::double precision) + COALESCE(t1.pcthbwet2011cat, 0::double precision) AS shedareadrainlake, COALESCE(t1.pcturbop2011cat * t1.catareasqkm * 0.10::double precision, 0::double precision) + COALESCE(t1.pcturblo2011cat * t1.catareasqkm * 0.35::double precision, 0::double precision) + COALESCE(t1.pcturbmd2011cat * t1.catareasqkm * 0.65::double precision, 0::double precision) + COALESCE(t1.pcturbhi2011cat * t1.catareasqkm * 0.9::double precision, 0::double precision) AS impareasqkm, t1.pctow2011cat * t1.catareasqkm AS ow2011cat, t1.pctice2011cat * t1.catareasqkm AS ice2011cat, (COALESCE(t1.pcturbop2011cat, 0::double precision) + COALESCE(t1.pcturblo2011cat, 0::double precision)) * t1.catareasqkm AS all_lowdensity2011cat, t1.pcturbop2011cat * t1.catareasqkm AS urbop2011cat, t1.pcturblo2011cat * t1.catareasqkm AS urblo2011cat, t1.pcturbmd2011cat * t1.catareasqkm AS urbmd2011cat, t1.pcturbhi2011cat * t1.catareasqkm AS urbhi2011cat, t1.pctbl2011cat * t1.catareasqkm AS bl2011cat, (COALESCE(t1.pctdecid2011cat, 0::double precision) + COALESCE(t1.pctconif2011cat, 0::double precision) + COALESCE(t1.pctmxfst2011cat, 0::double precision)) * t1.catareasqkm AS all_forest2011cat, t1.pctdecid2011cat * t1.catareasqkm AS decid2011cat, t1.pctconif2011cat * t1.catareasqkm AS conif2011cat, t1.pctmxfst2011cat * t1.catareasqkm AS mxfst2011cat, t1.pctshrb2011cat * t1.catareasqkm AS shrb2011cat, t1.pctgrs2011cat * t1.catareasqkm AS grs2011cat, t1.pcthay2011cat * t1.catareasqkm AS hay2011cat, t1.pctcrop2011cat * t1.catareasqkm AS crop2011cat, (COALESCE(t1.pcthay2011cat, 0::double precision) + COALESCE(t1.pctcrop2011cat, 0::double precision)) * t1.catareasqkm AS all_farm2011cat, t1.pctwdwet2011cat * t1.catareasqkm AS wdwet2011cat, t1.pcthbwet2011cat * t1.catareasqkm AS hbwet2011cat, (COALESCE(t1.pctwdwet2011cat, 0::double precision) + COALESCE(t1.pcthbwet2011cat, 0::double precision)) * t1.catareasqkm AS all_wetland2011cat
           FROM wikiwtershed.strmcat11 t1
      JOIN ( SELECT nhdplus_x_huc12.comid, nhdplus_x_huc12.huc12
                   FROM wikiwtershed.nhdplus_x_huc12) t2 ON t1.comid = t2.comid
   LEFT JOIN ( SELECT grndwter_tn_nhdplus.comid, grndwter_tn_nhdplus.sum AS tnsumgrnd
              FROM wikiwtershed.grndwter_tn_nhdplus) nut ON t1.comid = nut.comid
        )
 SELECT tmp.comid, tmp.huc12, tmp.catareasqkm, tmp.shedareadrainlake, COALESCE(
        CASE
            WHEN sum(tmp.tnsumgrnd) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.tnsumgrnd / sum(tmp.tnsumgrnd) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_tnsumgrnd_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.all_wetland2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.all_wetland2011cat / sum(tmp.all_wetland2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_all_wetland2011cat_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.all_lowdensity2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.all_lowdensity2011cat / sum(tmp.all_lowdensity2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_all_lowdensity2011cat_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.all_forest2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.all_forest2011cat / sum(tmp.all_forest2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_all_forest2011cat_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.all_farm2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.all_farm2011cat / sum(tmp.all_farm2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_all_farm2011cat_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.catareasqkm) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.catareasqkm / sum(tmp.catareasqkm) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_catarea_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.impareasqkm) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.impareasqkm / sum(tmp.impareasqkm) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_imparea_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.ow2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.ow2011cat / sum(tmp.ow2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_ow2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.ice2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.ice2011cat / sum(tmp.ice2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_ice2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.urbop2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.urbop2011cat / sum(tmp.urbop2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_urbop2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.urblo2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.urblo2011cat / sum(tmp.urblo2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_urblo2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.urbmd2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.urbmd2011cat / sum(tmp.urbmd2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_urbmd2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.urbhi2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.urbhi2011cat / sum(tmp.urbhi2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_urbhi2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.bl2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.bl2011cat / sum(tmp.bl2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_bl2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.decid2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.decid2011cat / sum(tmp.decid2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_decid2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.conif2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.conif2011cat / sum(tmp.conif2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_conif2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.mxfst2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.mxfst2011cat / sum(tmp.mxfst2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_mxfst2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.shrb2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.shrb2011cat / sum(tmp.shrb2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_shrb2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.grs2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.grs2011cat / sum(tmp.grs2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_grs2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.hay2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.hay2011cat / sum(tmp.hay2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_hay2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.crop2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.crop2011cat / sum(tmp.crop2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_crop2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.wdwet2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.wdwet2011cat / sum(tmp.wdwet2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_wdwet2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(tmp.hbwet2011cat) OVER (PARTITION BY tmp.huc12) > 0::double precision THEN tmp.hbwet2011cat / sum(tmp.hbwet2011cat) OVER (PARTITION BY tmp.huc12)
            ELSE NULL::double precision
        END, 0::double precision) AS p_hbwet2011catcomid_x_huc12, COALESCE(
        CASE
            WHEN sum(pt.pt_kgn_yr) OVER (PARTITION BY tmp.huc12)::double precision > 0::double precision THEN (pt.pt_kgn_yr / sum(pt.pt_kgn_yr) OVER (PARTITION BY tmp.huc12))::double precision
            ELSE NULL::double precision
        END, 0::double precision) AS p_pt_kgn_yr_x_huc12, COALESCE(
        CASE
            WHEN sum(pt.pt_kgp_yr) OVER (PARTITION BY tmp.huc12)::double precision > 0::double precision THEN (pt.pt_kgp_yr / sum(pt.pt_kgp_yr) OVER (PARTITION BY tmp.huc12))::double precision
            ELSE NULL::double precision
        END, 0::double precision) AS p_pt_kgp_yr_x_huc12, t1.qe_ma
   FROM tmp
   LEFT JOIN wikiwtershed.nhdplus_stream t1 ON tmp.comid = t1.comid
   LEFT JOIN ( SELECT ms_pointsource.comid, sum(ms_pointsource.kgn_yr) AS pt_kgn_yr, sum(ms_pointsource.kgp_yr) AS pt_kgp_yr
      FROM wikiwtershed.ms_pointsource
     GROUP BY ms_pointsource.comid) pt ON tmp.comid = pt.comid;

ALTER TABLE wikiwtershed.nhdcoefs
  OWNER TO drwiadmin;

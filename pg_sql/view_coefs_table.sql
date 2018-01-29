-- View: wikiwtershed.nhdcoefs
-- DROP VIEW wikiwtershed.nhdcoefs;
CREATE OR replace VIEW wikiwtershed.nhdcoefs AS
                       WITH tmp              AS
                       (
                              SELECT t1.comid,
                                     t2.huc12,
                                     t1.catareasqkm,
                                     t1.wsareasqkm,
                                     t1.catpctfull,
                                     t1.wspctfull,
                                     coalesce(t1.pctow2011cat, 0::DOUBLE precision) + coalesce(t1.pctwdwet2011cat, 0::DOUBLE PRECISION) + coalesce(t1.pcthbwet2011cat, 0::DOUBLE PRECISION)                                                                                                                                                                                                        AS shedareadrainlake,
                                     coalesce(t1.pcturbop2011cat * t1.catareasqkm * 0.10::DOUBLE PRECISION, 0::DOUBLE PRECISION) + coalesce(t1.pcturblo2011cat * t1.catareasqkm * 0.35::DOUBLE PRECISION, 0::DOUBLE PRECISION) + coalesce(t1.pcturbmd2011cat * t1.catareasqkm * 0.65::DOUBLE PRECISION, 0::DOUBLE PRECISION) + coalesce(t1.pcturbhi2011cat * t1.catareasqkm * 0.9::DOUBLE PRECISION, 0::DOUBLE PRECISION) AS impareasqkm,
                                     t1.pctow2011cat  * t1.catareasqkm                                                                                                                                                                                                        AS ow2011cat,
                                     t1.pctice2011cat * t1.catareasqkm                                                                                                                                                                                                        AS ice2011cat,
                                     (coalesce(t1.pcturbop2011cat, 0::DOUBLE PRECISION) + coalesce(t1.pcturblo2011cat, 0::DOUBLE PRECISION)) * t1.catareasqkm                                                                                                                                                                                                        AS all_lowdensity2011cat,
                                     t1.pcturbop2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urbop2011cat,
                                     t1.pcturblo2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urblo2011cat,
                                     t1.pcturbmd2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urbmd2011cat,
                                     t1.pcturbhi2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urbhi2011cat,
                                     t1.pctbl2011cat    * t1.catareasqkm                                                                                                                                                                                                        AS bl2011cat,
                                     (coalesce(t1.pctdecid2011cat, 0::DOUBLE PRECISION) + coalesce(t1.pctconif2011cat, 0::DOUBLE PRECISION) + coalesce(t1.pctmxfst2011cat, 0::DOUBLE PRECISION)) * t1.catareasqkm                                                                                                                                                                                                        AS all_forest2011cat,
                                     t1.pctdecid2011cat * t1.catareasqkm                                                                                                                                                                                                        AS decid2011cat,
                                     t1.pctconif2011cat * t1.catareasqkm                                                                                                                                                                                                        AS conif2011cat,
                                     t1.pctmxfst2011cat * t1.catareasqkm                                                                                                                                                                                                        AS mxfst2011cat,
                                     t1.pctshrb2011cat  * t1.catareasqkm                                                                                                                                                                                                        AS shrb2011cat,
                                     t1.pctgrs2011cat   * t1.catareasqkm                                                                                                                                                                                                        AS grs2011cat,
                                     t1.pcthay2011cat   * t1.catareasqkm                                                                                                                                                                                                        AS hay2011cat,
                                     t1.pctcrop2011cat  * t1.catareasqkm                                                                                                                                                                                                        AS crop2011cat,
                                     (coalesce(t1.pcthay2011cat, 0::DOUBLE PRECISION) + coalesce(t1.pctcrop2011cat, 0::DOUBLE PRECISION)) * t1.catareasqkm                                                                                                                                                                                                        AS all_farm2011cat,
                                     t1.pctwdwet2011cat * t1.catareasqkm                                                                                                                                                                                                        AS wdwet2011cat,
                                     t1.pcthbwet2011cat * t1.catareasqkm                                                                                                                                                                                                        AS hbwet2011cat,
                                     (coalesce(t1.pctwdwet2011cat, 0::DOUBLE PRECISION) + coalesce(t1.pcthbwet2011cat, 0::DOUBLE PRECISION)) * t1.catareasqkm                                                                                                                                                                                                        AS all_wetland2011cat
                              FROM   wikiwtershed.strmcat11 t1
                              join
                                     (
                                            SELECT nhdplus_x_huc12.comid,
                                                   nhdplus_x_huc12.huc12
                                            FROM   wikiwtershed.nhdplus_x_huc12) t2
                              ON     t1.comid = t2.comid
                       )
                SELECT    tmp.comid,
                          tmp.huc12,
                          tmp.catareasqkm,
                          tmp.shedareadrainlake,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.all_wetland2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.all_wetland2011cat / SUM(tmp.all_wetland2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_all_wetland2011cat_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.all_lowdensity2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.all_lowdensity2011cat / SUM(tmp.all_lowdensity2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_all_lowdensity2011cat_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.all_forest2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.all_forest2011cat / SUM(tmp.all_forest2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_all_forest2011cat_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.all_farm2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.all_farm2011cat / SUM(tmp.all_farm2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_all_farm2011cat_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.catareasqkm) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.catareasqkm / SUM(tmp.catareasqkm) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_catarea_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.impareasqkm) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.impareasqkm / SUM(tmp.impareasqkm) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_imparea_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.ow2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.ow2011cat / SUM(tmp.ow2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_ow2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.ice2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.ice2011cat / SUM(tmp.ice2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_ice2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.urbop2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urbop2011cat / SUM(tmp.urbop2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_urbop2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.urblo2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urblo2011cat / SUM(tmp.urblo2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_urblo2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.urbmd2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urbmd2011cat / SUM(tmp.urbmd2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_urbmd2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.urbhi2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urbhi2011cat / SUM(tmp.urbhi2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_urbhi2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.bl2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.bl2011cat / SUM(tmp.bl2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_bl2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.decid2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.decid2011cat / SUM(tmp.decid2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_decid2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.conif2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.conif2011cat / SUM(tmp.conif2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_conif2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.mxfst2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.mxfst2011cat / SUM(tmp.mxfst2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_mxfst2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.shrb2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.shrb2011cat / SUM(tmp.shrb2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_shrb2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.grs2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.grs2011cat / SUM(tmp.grs2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_grs2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.hay2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.hay2011cat / SUM(tmp.hay2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_hay2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.crop2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.crop2011cat / SUM(tmp.crop2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_crop2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.wdwet2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.wdwet2011cat / SUM(tmp.wdwet2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_wdwet2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(tmp.hbwet2011cat) over (PARTITION BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.hbwet2011cat / SUM(tmp.hbwet2011cat) over (PARTITION BY tmp.huc12)
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_hbwet2011catcomid_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(pt.pt_kgn_yr) over (PARTITION BY tmp.huc12)::DOUBLE PRECISION > 0::DOUBLE PRECISION THEN (pt.pt_kgn_yr / SUM(pt.pt_kgn_yr) over (PARTITION BY tmp.huc12))::DOUBLE PRECISION
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_pt_kgn_yr_x_huc12,
                          coalesce(
                          CASE
                                    WHEN SUM(pt.pt_kgp_yr) over (PARTITION BY tmp.huc12)::DOUBLE PRECISION > 0::DOUBLE PRECISION THEN (pt.pt_kgp_yr / SUM(pt.pt_kgp_yr) over (PARTITION BY tmp.huc12))::DOUBLE PRECISION
                                    ELSE NULL::DOUBLE PRECISION
                          END, 0::DOUBLE PRECISION) AS p_pt_kgp_yr_x_huc12,
                          t1.qe_ma
                FROM      tmp
                left join wikiwtershed.nhdplus_stream t1
                ON        tmp.comid = t1.comid
                left join
                          (
                                   SELECT   ms_pointsource.comid,
                                            SUM(ms_pointsource.kgn_yr) AS pt_kgn_yr,
                                            SUM(ms_pointsource.kgp_yr) AS pt_kgp_yr
                                   FROM     wikiwtershed.ms_pointsource
                                   GROUP BY ms_pointsource.comid) pt
                ON        tmp.comid = pt.comid;ALTER TABLE wikiwtershed.nhdcoefs owner TO drwiadmin;
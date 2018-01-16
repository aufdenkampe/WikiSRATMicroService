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
				     COALESCE(t1.pctow2011cat,0) + 	COALESCE(t1.pctwdwet2011cat,0) + COALESCE(t1.pcthbwet2011cat,0) As 				       ShedAreaDrainLake,	

                                     COALESCE(t1.pcturbop2011cat * t1.catareasqkm * 0.10::DOUBLE PRECISION, 0::DOUBLE PRECISION) 
                                     + COALESCE(t1.pcturblo2011cat * t1.catareasqkm * 0.35::DOUBLE PRECISION, 0::DOUBLE PRECISION) 
                                     + COALESCE(t1.pcturbmd2011cat * t1.catareasqkm * 0.65::DOUBLE PRECISION, 0::DOUBLE PRECISION) 
                                     + COALESCE(t1.pcturbhi2011cat * t1.catareasqkm * 0.9::DOUBLE PRECISION, 0::DOUBLE PRECISION) AS impareasqkm,
                                     t1.pctow2011cat    * t1.catareasqkm                                                                                                                                                                                                        AS ow2011cat,
                                     t1.pctice2011cat   * t1.catareasqkm                                                                                                                                                                                                        AS ice2011cat,
                                     t1.pcturbop2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urbop2011cat,
                                     t1.pcturblo2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urblo2011cat,
                                     t1.pcturbmd2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urbmd2011cat,
                                     t1.pcturbhi2011cat * t1.catareasqkm                                                                                                                                                                                                        AS urbhi2011cat,
                                     t1.pctbl2011cat    * t1.catareasqkm                                                                                                                                                                                                        AS bl2011cat,
                                     t1.pctdecid2011cat * t1.catareasqkm                                                                                                                                                                                                        AS decid2011cat,
                                     t1.pctconif2011cat * t1.catareasqkm                                                                                                                                                                                                        AS conif2011cat,
                                     t1.pctmxfst2011cat * t1.catareasqkm                                                                                                                                                                                                        AS mxfst2011cat,
                                     t1.pctshrb2011cat  * t1.catareasqkm                                                                                                                                                                                                        AS shrb2011cat,
                                     t1.pctgrs2011cat   * t1.catareasqkm                                                                                                                                                                                                        AS grs2011cat,
                                     t1.pcthay2011cat   * t1.catareasqkm                                                                                                                                                                                                        AS hay2011cat,
                                     t1.pctcrop2011cat  * t1.catareasqkm                                                                                                                                                                                                        AS crop2011cat,
                                     t1.pctwdwet2011cat * t1.catareasqkm                                                                                                                                                                                                        AS wdwet2011cat,
                                     t1.pcthbwet2011cat * t1.catareasqkm                                                                                                                                                                                                        AS hbwet2011cat
                              FROM   wikiwtershed.strmcat11 t1 
                              JOIN 
                                     ( 
                                            SELECT nhdplus_x_huc12.comid,
                                                   nhdplus_x_huc12.huc12
                                            FROM   wikiwtershed.nhdplus_x_huc12) t2
                              ON     t1.comid = t2.comid 
                       )SELECT          tmp.comid, 
                                tmp.huc12, 
                                tmp.catareasqkm,
                                tmp.ShedAreaDrainLake, 
                                COALESCE(CASE 
					WHEN Sum(tmp.catareasqkm) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.catareasqkm / sum(tmp.catareasqkm) OVER (partition BY tmp.huc12)
                                        ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_catarea_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.impareasqkm) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.impareasqkm / sum(tmp.impareasqkm) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_imparea_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.ow2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.ow2011cat / sum(tmp.ow2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_ow2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.ice2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.ice2011cat / sum(tmp.ice2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_ice2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.urbop2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urbop2011cat / sum(tmp.urbop2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_urbop2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.urblo2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urblo2011cat / sum(tmp.urblo2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_urblo2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.urbmd2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urbmd2011cat / sum(tmp.urbmd2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_urbmd2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.urbhi2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.urbhi2011cat / sum(tmp.urbhi2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_urbhi2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.bl2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.bl2011cat / sum(tmp.bl2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_bl2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.decid2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.decid2011cat / sum(tmp.decid2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_decid2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.conif2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.conif2011cat / sum(tmp.conif2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_conif2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.mxfst2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.mxfst2011cat / sum(tmp.mxfst2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_mxfst2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.shrb2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.shrb2011cat / sum(tmp.shrb2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_shrb2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.grs2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.grs2011cat / sum(tmp.grs2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_grs2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.hay2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.hay2011cat / sum(tmp.hay2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_hay2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.crop2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.crop2011cat / sum(tmp.crop2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_crop2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.wdwet2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.wdwet2011cat / sum(tmp.wdwet2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_wdwet2011catcomid_x_huc12, 
                                COALESCE(CASE 
 					WHEN sum(tmp.hbwet2011cat) OVER (partition BY tmp.huc12) > 0::DOUBLE PRECISION THEN tmp.hbwet2011cat / sum(tmp.hbwet2011cat) OVER (partition BY tmp.huc12)
                                                ELSE NULL::DOUBLE PRECISION
                                END,0) AS p_hbwet2011catcomid_x_huc12 , 
                                t1.qe_ma 
                FROM            tmp 
                LEFT OUTER JOIN wikiwtershed.nhdplus_stream t1 
                ON              tmp.comid=t1.comid;ALTER TABLE wikiwtershed.nhdcoefs owner TO drwiadmin;
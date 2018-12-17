-- Download nationwide seamless NHD plus dataset open the NHDFlowline_Network linear file
-- select comid and qe_ma layer
-- export as csv
-- load into postgres file has 2691339 points

SELECT id, "COMID", "QE_MA"
  FROM wikiwtershed.comid_qe_ma_new limit 10;

alter table wikiwtershed.comid_qe_ma_new drop column id 
SELECT count(*)
  FROM wikiwtershed.comid_qe_ma_new limit 10;

alter table wikiwtershed.comid_qe_ma_new  rename "COMID" to  comid;
alter table wikiwtershed.comid_qe_ma_new  rename "QE_MA"   to qe_ma;

ALTER TABLE wikiwtershed.comid_qe_ma_new
  ADD CONSTRAINT comid_qe_ma_new_pk PRIMARY KEY(comid);

select replace(comid,',','') from wikiwtershed.comid_qe_ma_new  limit 10


alter table wikiwtershed.comid_qe_ma_new alter column comid type integer using replace(comid,',','')::integer;

alter table wikiwtershed.comid_qe_ma_new alter column qe_ma type double precision using replace(qe_ma,',','')::double precision;

--CHeck
Select 
old.comid
,old.qe_ma nqe_ma
,new.qe_ma oqe_ma

From wikiwtershed.comid_qe_ma_new new join wikiwtershed.nhdplus_qe_ma old
on old.comid = new.comid 
where new.qe_ma = old.qe_ma
limit 100
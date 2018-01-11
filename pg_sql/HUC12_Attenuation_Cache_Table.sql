
-- tables to build

-- 1) that holds an array for all comids from top to bottom of the dissolve frac

-- comid, {.74,.95,.78,...,}

--1 a table (or the same table that contains the reduction by mulltyipling the 
--2 nested calc reduction (eg.84 for tn) (1 * (1- (.74*.84))* (1-(.95*.84)) etc coeficients
--3 to calculate for each huc12 simply multiply 2 * eac comid's percent of the huc12 and sum. giving overall percent..


Create Table wikiwtershed.HUC12_att_tmptbl1_comidextarray
(
comid integer not null,
rte float[]
);

ALTER TABLE wikiwtershed.HUC12_att_tmptbl1_comidextarray ALTER COLUMN comid SET NOT NULL;

set enable_seqscan = off;

truncate table wikiwtershed.HUC12_att_tmptbl1_comidextarray ;

Insert Into wikiwtershed.HUC12_att_tmptbl1_comidextarray (comid,rte)
(
With Recursive included_parts(comid, rte, plce, huc12, hydroseq) As 
(
Select * From
(
Select lnx.comid, (shed.shedareadrainlake/100), 1::integer as plce, huc12, hydroseq
From wikiwtershed.nhdplus_stream_nsidx lnx join wikiwtershed.cache_nhdcoefs shed
On lnx.comid = shed.comid
limit 10000
--where lnx.comid not in (select comid from wikiwtershed.HUC12_att_tmptbl1_comidextarray)
--limit 100000
)t
Union All
Select included_parts.comid, shd, included_parts.plce + 1 as plce, included_parts.huc12, t1.hydroseq
From  
	(
	Select lnx.comid, (shed.shedareadrainlake/100) as shd,  huc12, hydroseq, dnhydroseq
	From wikiwtershed.nhdplus_stream_nsidx lnx join wikiwtershed.cache_nhdcoefs shed
	On lnx.comid = shed.comid
	) t1 
	join included_parts 
	on t1.dnhydroseq = included_parts.hydroseq and t1.huc12 = included_parts.huc12 
)
Select 
	comid, array_agg(rte order by plce asc)::float[]
From included_parts
Group By comid  
) 

 




Create Table wikiwtershed.HUC12_att
(
huc12 integer not null,
tpload_hp_att float,
);

Alter Table Huc12_att add constraint pkhuc12_att Primary Key (huc12);

Insert into huc12_att (huc12)
(
Select huc12 
From wikiwtershed.boundary_huc12
);

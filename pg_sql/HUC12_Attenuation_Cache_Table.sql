
-- tables to build

-- 1) that holds an array for all comids from top to bottom of the dissolve frac

-- comid, {.74,.95,.78,...,}

--1 a table (or the same table that contains the reduction by mulltyipling the 
--2 nested calc reduction (eg.84 for tn) (1 * (1- (.74*.84))* (1-(.95*.84)) etc coeficients
--3 to calculate for each huc12 simply multiply 2 * eac comid's percent of the huc12 and sum. giving overall percent..




-- based on converstion with Barry evans
Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray
Add Column  rdc_0 float ;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray
Add Column  rdc_22 float;

Alter Table wikiwtershed.HUC12_att_tmptbl1_comidextarray
Add Column  rdc_42 float;

Drop Table if Exists wikiwtershed.HUC12_att_tmptbl1_comidextarray;

Create Table wikiwtershed.HUC12_att_tmptbl1_comidextarray
(
comid integer not null,
rte float[],
rdc_84 float,
rdc_29 float,
rdc_12 float,
);

ALTER TABLE wikiwtershed.HUC12_att_tmptbl1_comidextarray ALTER COLUMN comid SET NOT NULL;

set enable_seqscan = off;

truncate table wikiwtershed.HUC12_att_tmptbl1_comidextarray ;

Insert Into wikiwtershed.HUC12_att_tmptbl1_comidextarray 
(comid,
--rte,
rdc_84,
rdc_29,
rdc_12,
rdc_42,
rdc_22,
rdc_0

)
(
With Recursive included_parts(comid, rte, plce, huc12, hydroseq, calc84,calc29,calc12, calc42, calc22, calc0 ) As 
(
Select * From
(
Select lnx.comid, (shed.shedareadrainlake/100), 1::integer as plce, huc12, hydroseq
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.84)::float ) calc84
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.29)::float ) calc29
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.12)::float ) calc12
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.42)::float ) calc42
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.22)::float ) calc22
	, 1 - ( (shed.shedareadrainlake/100)::float * (0.0)::float  ) calc0

	
From wikiwtershed.nhdplus_stream_nsidx lnx join wikiwtershed.cache_nhdcoefs shed
On lnx.comid = shed.comid
 
--where lnx.comid not in (select comid from wikiwtershed.HUC12_att_tmptbl1_comidextarray)
--limit 100000
)t
Union All
Select included_parts.comid, shd, included_parts.plce + 1 as plce, included_parts.huc12, t1.hydroseq,
	included_parts.calc84 * ( 1 - ( shd * (0.84)::float )),
	included_parts.calc29 * ( 1 - ( shd * (0.29)::float )), 
	included_parts.calc12 * ( 1 - ( shd * (0.12)::float )),
	included_parts.calc42 * ( 1 - ( shd * (0.42)::float )),
	included_parts.calc22 * ( 1 - ( shd * (0.22)::float )), 
	included_parts.calc0  * ( 1 - ( shd * (0.0)::float  )) 	 
From  
	(
	Select lnx.comid, (shed.shedareadrainlake/100)::float as shd,  huc12, hydroseq, dnhydroseq
	
	From wikiwtershed.nhdplus_stream_nsidx lnx join wikiwtershed.cache_nhdcoefs shed
	On lnx.comid = shed.comid
	) t1 
	join included_parts 
	on t1.dnhydroseq = included_parts.hydroseq and t1.huc12 = included_parts.huc12 
)
Select 
	comid, 
	--array_agg(rte order by plce asc)::float[],
	min(calc84), min(calc29), min(calc12),min(calc42), min(calc22), min(calc0)
From included_parts
Group By comid  
) ;
-- runs in 1438120

ALTER TABLE wikiwtershed.huc12_att_tmptbl1_comidextarray
  ADD PRIMARY KEY (comid);

Select * from wikiwtershed.HUC12_att_tmptbl1_comidextarray limit 100

Drop Table if Exists wikiwtershed.HUC12_att2;

Create Table wikiwtershed.HUC12_att2
(
huc12 character varying not null,

ow2011_tp_att_coef float,
ice2011_tp_att_coef float,
urbop2011_tp_att_coef float,
urblo2011_tp_att_coef float,
urbmd2011_tp_att_coef float,
urbhi2011_tp_att_coef float,
bl2011_tp_att_coef float,
decid2011_tp_att_coef float,
conif2011_tp_att_coef float,
mxfst2011_tp_att_coef float,
shrb2011_tp_att_coef float,
grs2011_tp_att_coef float,
hay2011_tp_att_coef float,
crop2011_tp_att_coef float,
wdwet2011_tp_att_coef float,
hbwet2011_tp_att_coef float,
pt_2011_tp_att_coef float,
-- Add New ones based on convesation with Barry 

all_wetland2011cat_tp_att_coef float,
lowdensity2011cat_tp_att_coef float,
all_forest2011cat_tp_att_coef float,
all_farm2011cat_tp_att_coef float,
streambnk_tp_att_coef float,

-- add in ground water 5_22_18
grnd_tp_att_coef float,


ow2011_tn_att_coef float,
ice2011_tn_att_coef float,
urbop2011_tn_att_coef float,
urblo2011_tn_att_coef float,
urbmd2011_tn_att_coef float,
urbhi2011_tn_att_coef float,
bl2011_tn_att_coef float,
decid2011_tn_att_coef float,
conif2011_tn_att_coef float,
mxfst2011_tn_att_coef float,
shrb2011_tn_att_coef float,
grs2011_tn_att_coef float,
hay2011_tn_att_coef float,
crop2011_tn_att_coef float,
wdwet2011_tn_att_coef float,
hbwet2011_tn_att_coef float,
pt_2011_tn_att_coef float,

all_wetland2011cat_tn_att_coef float,
lowdensity2011cat_tn_att_coef float,
all_forest2011cat_tn_att_coef float,
all_farm2011cat_tn_att_coef float,
streambnk_tn_att_coef float,

-- add in ground water 5_22_18
grnd_tn_att_coef float,

ow2011_tss_att_coef float,
ice2011_tss_att_coef float,
urbop2011_tss_att_coef float,
urblo2011_tss_att_coef float,
urbmd2011_tss_att_coef float,
urbhi2011_tss_att_coef float,
bl2011_tss_att_coef float,
decid2011_tss_att_coef float,
conif2011_tss_att_coef float,
mxfst2011_tss_att_coef float,
shrb2011_tss_att_coef float,
grs2011_tss_att_coef float,
hay2011_tss_att_coef float,
crop2011_tss_att_coef float,
wdwet2011_tss_att_coef float,
hbwet2011_tss_att_coef float,

all_wetland2011cat_tss_att_coef float,
lowdensity2011cat_tss_att_coef float,
all_forest2011cat_tss_att_coef float,
all_farm2011cat_tss_att_coef float,
streambnk_tss_att_coef float

);

set enable_seqscan = off; 


insert into wikiwtershed.HUC12_att2
(
huc12,
ow2011_tp_att_coef,
ice2011_tp_att_coef,
urbop2011_tp_att_coef,
urblo2011_tp_att_coef,
urbmd2011_tp_att_coef,
urbhi2011_tp_att_coef,
bl2011_tp_att_coef,
decid2011_tp_att_coef,
conif2011_tp_att_coef,
mxfst2011_tp_att_coef,
shrb2011_tp_att_coef,
grs2011_tp_att_coef,
hay2011_tp_att_coef,
crop2011_tp_att_coef,
wdwet2011_tp_att_coef,
hbwet2011_tp_att_coef,
pt_2011_tp_att_coef,

all_wetland2011cat_tp_att_coef,
lowdensity2011cat_tp_att_coef,
all_forest2011cat_tp_att_coef,
all_farm2011cat_tp_att_coef,
streambnk_tp_att_coef,

-- Added in 5_22_18
grnd_tp_att_coef,

ow2011_tn_att_coef,
ice2011_tn_att_coef,
urbop2011_tn_att_coef,
urblo2011_tn_att_coef,
urbmd2011_tn_att_coef,
urbhi2011_tn_att_coef,
bl2011_tn_att_coef,
decid2011_tn_att_coef,
conif2011_tn_att_coef,
mxfst2011_tn_att_coef,
shrb2011_tn_att_coef,
grs2011_tn_att_coef,
hay2011_tn_att_coef,
crop2011_tn_att_coef,
wdwet2011_tn_att_coef,
hbwet2011_tn_att_coef,
pt_2011_tn_att_coef,

all_wetland2011cat_tn_att_coef,
lowdensity2011cat_tn_att_coef,
all_forest2011cat_tn_att_coef,
all_farm2011cat_tn_att_coef,
streambnk_tn_att_coef,


-- Added in 5_22_18
grnd_tn_att_coef,

ow2011_tss_att_coef,
ice2011_tss_att_coef,
urbop2011_tss_att_coef,
urblo2011_tss_att_coef,
urbmd2011_tss_att_coef,
urbhi2011_tss_att_coef,
bl2011_tss_att_coef,
decid2011_tss_att_coef,
conif2011_tss_att_coef,
mxfst2011_tss_att_coef,
shrb2011_tss_att_coef,
grs2011_tss_att_coef,
hay2011_tss_att_coef,
crop2011_tss_att_coef,
wdwet2011_tss_att_coef,
hbwet2011_tss_att_coef,

all_wetland2011cat_tss_att_coef,
lowdensity2011cat_tss_att_coef,
all_forest2011cat_tss_att_coef,
all_farm2011cat_tss_att_coef,
streambnk_tss_att_coef
)

Select 
hcn.huc12,

sum(coalesce(p_ow2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_ice2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_urbop2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_urblo2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_urbmd2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_urbhi2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_bl2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_decid2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_conif2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_mxfst2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_shrb2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_grs2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_hay2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_crop2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_wdwet2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_hbwet2011catcomid_x_huc12,0) 	* rdc_22),
sum(coalesce(p_pt_kgp_yr_x_huc12,0) 		* rdc_22),

sum(coalesce(p_all_wetland2011cat_x_huc12,0) 	* rdc_22),
sum(coalesce(p_all_lowdensity2011cat_x_huc12,0) * rdc_22),
sum(coalesce(p_all_forest2011cat_x_huc12,0) 	* rdc_22),
sum(coalesce(p_all_farm2011cat_x_huc12,0) 	* rdc_22),
--streambank is special
(
( sum(coalesce(p_imparea_x_huc12,0) 	* rdc_22) * 0.60 ) +
( sum(coalesce(p_catarea_x_huc12,0) 	* rdc_22) * 0.40 )
),

-- Add in subsurface
sum(coalesce(p_tnsumgrnd_x_huc12,0) 	* rdc_22),

sum(coalesce(p_ow2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_ice2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_urbop2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_urblo2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_urbmd2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_urbhi2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_bl2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_decid2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_conif2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_mxfst2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_shrb2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_grs2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_hay2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_crop2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_wdwet2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_hbwet2011catcomid_x_huc12,0) 	* rdc_0),
sum(coalesce(p_pt_kgn_yr_x_huc12	,0) 	* rdc_0),

sum(coalesce(p_all_wetland2011cat_x_huc12,0) 	* rdc_0),
sum(coalesce(p_all_lowdensity2011cat_x_huc12,0) * rdc_0),
sum(coalesce(p_all_forest2011cat_x_huc12,0) 	* rdc_0),
sum(coalesce(p_all_farm2011cat_x_huc12,0) 	* rdc_0),
--streambank is special
(
( sum(coalesce(p_imparea_x_huc12,0) 	* rdc_0) * 0.60 ) +
( sum(coalesce(p_catarea_x_huc12,0) 	* rdc_0) * 0.40 )
),

-- Add in subsurface
sum(coalesce(p_tnsumgrnd_x_huc12,0) 	* rdc_0),


sum(coalesce(p_ow2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_ice2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_urbop2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_urblo2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_urbmd2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_urbhi2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_bl2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_decid2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_conif2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_mxfst2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_shrb2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_grs2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_hay2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_crop2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_wdwet2011catcomid_x_huc12,0) 	* rdc_42),
sum(coalesce(p_hbwet2011catcomid_x_huc12,0) 	* rdc_42), 

sum(coalesce(p_all_wetland2011cat_x_huc12,0) 	* rdc_42),
sum(coalesce(p_all_lowdensity2011cat_x_huc12,0) * rdc_42),
sum(coalesce(p_all_forest2011cat_x_huc12,0) 	* rdc_42),
sum(coalesce(p_all_farm2011cat_x_huc12,0) 	* rdc_42),
--streambank is special
(
( sum(coalesce(p_imparea_x_huc12,0) 	* rdc_42) * 0.60 ) +
( sum(coalesce(p_catarea_x_huc12,0) 	* rdc_42) * 0.40 )
)



From 
	wikiwtershed.cache_nhdcoefs ncfs
	join
	wikiwtershed.nhdplus_x_huc12 hcn
	ON ncfs.comid = hcn.comid

	join
	wikiwtershed.huc12_att_tmptbl1_comidextarray ncfsa
	on ncfs.comid = ncfsa.comid
Where hcn.Huc12 is not null	
Group By hcn.huc12;	 

	
Alter Table wikiwtershed.HUC12_att2 add constraint pkhuc12_att10 Primary Key (huc12);

grant select on wikiwtershed.HUC12_att  to ms_select;

Drop Table If Exists wikiwtershed.HUC12_att;

Alter Table wikiwtershed.HUC12_att2 Rename TO HUC12_att;

Alter Table wikiwtershed.HUC12_att Rename TO HUC12_att_new;




 
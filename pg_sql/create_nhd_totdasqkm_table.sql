
create Table wikiwtershed.nhdplus_totdasqkm As
select comid, totdasqkm FROM wikiwtershed.nhdplus_stream  ;


ALTER TABLE wikiwtershed.nhdplus_totdasqkm
  ADD PRIMARY KEY (comid);

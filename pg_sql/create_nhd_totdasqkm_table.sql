
create Table wikiwtershed.nhdplus_totdasqkm As
select comid, totdasqkm FROM wikiwtershed.nhdplus_stream  ;


ALTER TABLE wikiwtershed.nhdplus_totdasqkm
  ADD PRIMARY KEY (comid);

grant select on wikiwtershed.nhdplus_totdasqkm to ms_select
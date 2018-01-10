Select 
*
From wikiwtershed.nhdplus_stream_nsidx
Where   dnhydroseq = hydroseq
-- 0

Select 
*
From wikiwtershed.nhdplus_stream_nsidx
Where   dnhydroseq > hydroseq
-- 0

Select 
count(*)
From wikiwtershed.nhdplus_stream_nsidx
Where   dnhydroseq < hydroseq
2,159,000
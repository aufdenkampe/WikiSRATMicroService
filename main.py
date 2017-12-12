from StringParser import StringParser

test = StringParser.parse("HotSpotMap( huc12 (181243213421,181243213421, 441243213421) tpload_hp (123,156,1512) tploadcrop (5672,125,82435) tpwooded ( 721435,1345,12435) tssloadseptic (37,26,85))")
for i in range(0, len(test)):
    print(test[i])
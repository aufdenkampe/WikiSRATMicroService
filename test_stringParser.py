from unittest import TestCase
from StringParser import StringParser


class TestStringParser(TestCase):
    def test_parse(self):
        expected = [
            {
                "huc12": 181243213421,
                "tpload_hp": 123,
                "tpload_crop": 5672,
                "tpwooded": 721435,
                "tssloadseptic": 367
            },
            {
                "huc12": 181243213421,
                "tpload_hp": 156,
                "tpload_crop": 125,
                "tpwooded": 1345,
                "tssloadseptic": 26
            },
            {
                "huc12": 441243213421,
                "tpload_hp": 1512,
                "tpload_crop": 82435,
                "tpwooded": 12435,
                "tssloadseptic": 85
            },

        ]
        self.widget = StringParser.parse("HotSpotMap( huc12 (181243213421,181243213421, 441243213421) tpload_hp (123,156,1512) tploadcrop (5672,125,82435) tpwooded ( 721435,1345,12435) tssloadseptic (37,26,85))")
        self.assertIsInstance(self.widget,list,msg="Did not return dictionary")
        self.assertEqual(len(self.widget), 3)
        for i in range(0, len(self.widget)):
            self.assertItemsEqual(self.widget[i], expected[i], msg="Invalid huc12 data")

    #self.fail()

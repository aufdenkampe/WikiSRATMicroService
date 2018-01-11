from unittest import TestCase
from StringParser import StringParser

class TestStringParser(TestCase):
    def test_convert_string(self):
        self.sut = StringParser.convert_string_to_valid_type("a string")
        self.assertIsInstance(self.sut, str)
    def test_convert_int(self):
        self.sut = StringParser.convert_string_to_valid_type("1000")
        self.assertIsInstance(self.sut, int)
    def test_convert_float(self):
        self.sut = StringParser.convert_string_to_valid_type("99.99")
        self.assertIsInstance(self.sut, float)
    def test_convert_notstring(self):
        with self.assertRaises(AssertionError):
            self.sut = StringParser.convert_string_to_valid_type({})

    def test_parse(self):
        expected = [
            {
                "huc12": 181243213421,
                "tpload_hp": 123,
                "tssload_crop": 5672,
                "tpload_Wooded": 721435,
                "tnload_septics": 37
            },
            {
                "huc12": 181243213421,
                "tpload_hp": 156,
                "tssload_crop": 125,
                "tpload_Wooded": 1345,
                "tnload_septics": 26
            },
            {
                "huc12": 441243213421,
                "tpload_hp": 1512,
                "tssload_crop": 82435,
                "tpload_Wooded": 12435,
                "tnload_septics": 85
            },

        ]
        self.sut = StringParser.parse("HotSpotMap( huc12 (181243213421,181243213421, 441243213421) tpload_hp (123,156,1512) tssload_crop (5672,125,82435) tpload_Wooded ( 721435,1345,12435) tnload_septics (37,26,85))")
        self.assertIsInstance(self.sut, list, msg="Did not return an array")
        self.assertEqual(len(self.sut), 3)
        for i in range(0, len(self.sut)):
            self.assertDictEqual(self.sut[i], expected[i], msg="Invalid huc12 data")

    # def test_check_not_a_hotspot(self):
    #     with self.assertRaises(AttributeError):
    #         self.sut = StringParser.parse("NotAHotSpotMap(ugly)")
    #         print(self.sut)

    def test_check_no_huc12(self):
        with self.assertRaisesRegex(AttributeError,"'18124321342a' is not of type 'integer"):
            self.sut = StringParser.parse("HotSpotMap( huc12 (18124321342a) tpload_hp (1512))")

    def test_check_not_valid_attribute(self):
        with self.assertRaisesRegex(AttributeError,"'something' is not of type 'number'"):
            self.sut = StringParser.parse("HotSpotMap( huc12 (181243213421,181243213422) tpload_hp (123,something))")

    def test_check_not_the_right_number_of_hucs(self):
        with self.assertRaisesRegex(AttributeError,'Inconsistent number of values \(tpload_hp\)'):
            self.sut = StringParser.parse("HotSpotMap( huc12 (181243213421) tpload_hp (1512,162))")

    def test_invalid_attibute(self):
        with self.assertRaisesRegex(AttributeError,"Additional properties are not allowed \('somthing' was unexpected\)"):
            self.sut = StringParser.parse("HotSpotMap( huc12 (181243213421,181243213422) somthing (1512,162))")

    def test_attribute_without_name(self):
        # with self.assertRaisesRegex(AttributeError,"Additional properties are not allowed \('somthing' was unexpected\)"):
            self.sut = StringParser.parse("HotSpotMap( huc12 (181243213421,181243213422) (1512,162))")
            print(self.sut)



    #self.fail()

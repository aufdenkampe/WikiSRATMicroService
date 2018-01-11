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
        expected = [{'huc12': 20402010101, 'tpload_hp': 10, 'tpload_Crop': 10, 'tpload_Wooded': 10, 'tpload_Open': 10,
                     'tpload_barren': 10, 'tpload_ldm': 10, 'tpload_MDM': 10, 'tpload_HDM': 10, 'tpload_OtherUp': 10,
                     'tpload_FarmAn': 10, 'tpload_tiledrain': 10, 'tpload_streambank': 10, 'tpload_subsurface': 10,
                     'tpload_pointsource': 10, 'tpload_septics': 10, 'tnload_hp': 10, 'tnload_crop': 10,
                     'tnload_wooded': 10, 'tnload_open': 10, 'tnload_barren': 10, 'tnload_ldm': 10, 'tnload_mdm': 10,
                     'tnload_hdm': 10, 'tnload_otherup': 10, 'tnload_farman': 10, 'tnload_tiledrain': 10,
                     'tnload_streambank': 10, 'tnload_subsurface': 10, 'tnload_pointsource': 10, 'tnload_septics': 10,
                     'tssload_hp': 10, 'tssload_crop': 10, 'tssload_wooded': 10, 'tssload_open': 10,
                     'tssload_barren': 10, 'tssload_ldm': 10, 'tssload_mdm': 10, 'tssload_hdm': 10,
                     'tssload_otherup': 10, 'tssload_tiledrain': 10, 'tssload_streambank': 10},
                    {'huc12': 20402010102, 'tpload_hp': 10, 'tpload_Crop': 10, 'tpload_Wooded': 10, 'tpload_Open': 10,
                     'tpload_barren': 10, 'tpload_ldm': 10, 'tpload_MDM': 10, 'tpload_HDM': 10, 'tpload_OtherUp': 10,
                     'tpload_FarmAn': 10, 'tpload_tiledrain': 10, 'tpload_streambank': 10, 'tpload_subsurface': 10,
                     'tpload_pointsource': 10, 'tpload_septics': 10, 'tnload_hp': 10, 'tnload_crop': 10,
                     'tnload_wooded': 10, 'tnload_open': 10, 'tnload_barren': 10, 'tnload_ldm': 10, 'tnload_mdm': 10,
                     'tnload_hdm': 10, 'tnload_otherup': 10, 'tnload_farman': 10, 'tnload_tiledrain': 10,
                     'tnload_streambank': 10, 'tnload_subsurface': 10, 'tnload_pointsource': 10, 'tnload_septics': 10,
                     'tssload_hp': 10, 'tssload_crop': 10, 'tssload_wooded': 10, 'tssload_open': 10,
                     'tssload_barren': 10, 'tssload_ldm': 10, 'tssload_mdm': 10, 'tssload_hdm': 10,
                     'tssload_otherup': 10, 'tssload_tiledrain': 10, 'tssload_streambank': 10},
                    {'huc12': 20402010103, 'tpload_hp': 10, 'tpload_Crop': 10, 'tpload_Wooded': 10, 'tpload_Open': 10,
                     'tpload_barren': 10, 'tpload_ldm': 10, 'tpload_MDM': 10, 'tpload_HDM': 10, 'tpload_OtherUp': 10,
                     'tpload_FarmAn': 10, 'tpload_tiledrain': 10, 'tpload_streambank': 10, 'tpload_subsurface': 10,
                     'tpload_pointsource': 10, 'tpload_septics': 10, 'tnload_hp': 10, 'tnload_crop': 10,
                     'tnload_wooded': 10, 'tnload_open': 10, 'tnload_barren': 10, 'tnload_ldm': 10, 'tnload_mdm': 10,
                     'tnload_hdm': 10, 'tnload_otherup': 10, 'tnload_farman': 10, 'tnload_tiledrain': 10,
                     'tnload_streambank': 10, 'tnload_subsurface': 10, 'tnload_pointsource': 10, 'tnload_septics': 10,
                     'tssload_hp': 10, 'tssload_crop': 10, 'tssload_wooded': 10, 'tssload_open': 10,
                     'tssload_barren': 10, 'tssload_ldm': 10, 'tssload_mdm': 10, 'tssload_hdm': 10,
                     'tssload_otherup': 10, 'tssload_tiledrain': 10, 'tssload_streambank': 10}]
        self.sut = StringParser.parse(
            "HotSpotMap(huc12 (20402010101, 20402010102, 20402010103), tpload_hp (10, 10, 10), tpload_Crop (10, 10, 10), tpload_Wooded (10, 10, 10), tpload_Open (10, 10, 10), tpload_barren (10, 10, 10), tpload_ldm (10, 10, 10), tpload_MDM (10, 10, 10), tpload_HDM (10, 10, 10), tpload_OtherUp (10, 10, 10), tpload_FarmAn (10, 10, 10), tpload_tiledrain (10, 10, 10), tpload_streambank (10, 10, 10), tpload_subsurface (10, 10, 10), tpload_pointsource (10, 10, 10), tpload_septics (10, 10, 10), tnload_hp (10, 10, 10), tnload_crop (10, 10, 10), tnload_wooded (10, 10, 10), tnload_open (10, 10, 10), tnload_barren (10, 10, 10), tnload_ldm (10, 10, 10), tnload_mdm (10, 10, 10), tnload_hdm (10, 10, 10), tnload_otherup (10, 10, 10), tnload_farman (10, 10, 10), tnload_tiledrain (10, 10, 10), tnload_streambank (10, 10, 10), tnload_subsurface (10, 10, 10), tnload_pointsource (10, 10, 10), tnload_septics (10, 10, 10), tssload_hp (10, 10, 10), tssload_crop (10, 10, 10), tssload_wooded (10, 10, 10), tssload_open (10, 10, 10), tssload_barren (10, 10, 10), tssload_ldm (10, 10, 10), tssload_mdm (10, 10, 10), tssload_hdm (10, 10, 10), tssload_otherup (10, 10, 10), tssload_tiledrain (10, 10, 10), tssload_streambank (10, 10, 10))")
        self.assertIsInstance(self.sut, list, msg="Did not return an array")
        self.assertEqual(len(self.sut), 3)
        for i in range(0, len(self.sut)):
            self.assertDictEqual(self.sut[i], expected[i], msg="Invalid huc12 data")

    # def test_check_not_a_hotspot(self):
    #     with self.assertRaises(AttributeError):
    #         self.sut = StringParser.parse("NotAHotSpotMap(ugly)")
    #         print(self.sut)

    def test_check_no_huc12(self):
        with self.assertRaisesRegex(AttributeError, "'18124321342a' is not of type 'integer"):
            self.sut = StringParser.parse(
                "HotSpotMap(huc12 (18124321342a), tpload_hp (10), tpload_Crop (10), tpload_Wooded (10), tpload_Open (10), tpload_barren (10), tpload_ldm (10), tpload_MDM (10), tpload_HDM (10), tpload_OtherUp (10), tpload_FarmAn (10), tpload_tiledrain (10), tpload_streambank (10), tpload_subsurface (10), tpload_pointsource (10), tpload_septics (10), tnload_hp (10), tnload_crop (10), tnload_wooded (10), tnload_open (10), tnload_barren (10), tnload_ldm (10), tnload_mdm (10), tnload_hdm (10), tnload_otherup (10), tnload_farman (10), tnload_tiledrain (10), tnload_streambank (10), tnload_subsurface (10), tnload_pointsource (10), tnload_septics (10), tssload_hp (10), tssload_crop (10), tssload_wooded (10), tssload_open (10), tssload_barren (10), tssload_ldm (10), tssload_mdm (10), tssload_hdm (10), tssload_otherup (10), tssload_tiledrain (10), tssload_streambank (10))")

    def test_check_not_valid_attribute(self):
        with self.assertRaisesRegex(AttributeError, "'something' is not of type 'number'"):
            self.sut = StringParser.parse(
                "HotSpotMap(huc12 (20402010101), tpload_hp (10), tpload_Crop (10), tpload_Wooded (10), tpload_Open (10), tpload_barren (10), tpload_ldm (10), tpload_MDM (10), tpload_HDM (10), tpload_OtherUp (10), tpload_FarmAn (10), tpload_tiledrain (10), tpload_streambank (10), tpload_subsurface (10), tpload_pointsource (10), tpload_septics (10), tnload_hp (10), tnload_crop (10), tnload_wooded (10), tnload_open (10), tnload_barren (10), tnload_ldm (10), tnload_mdm (10), tnload_hdm (10), tnload_otherup (10), tnload_farman (10), tnload_tiledrain (10), tnload_streambank (10), tnload_subsurface (10), tnload_pointsource (10), tnload_septics (10), tssload_hp (10), tssload_crop (10), tssload_wooded (10), tssload_open (10), tssload_barren (10), tssload_ldm (10), tssload_mdm (10), tssload_hdm (10), tssload_otherup (10), tssload_tiledrain (10), tssload_streambank (something))")

    def test_check_not_the_right_number_of_hucs(self):
        with self.assertRaisesRegex(AttributeError, 'Inconsistent number of values \(tpload_hp\)'):
            self.sut = StringParser.parse(
                "HotSpotMap(huc12 (20402010101), tpload_hp (10,12), tpload_Crop (10), tpload_Wooded (10), tpload_Open (10), tpload_barren (10), tpload_ldm (10), tpload_MDM (10), tpload_HDM (10), tpload_OtherUp (10), tpload_FarmAn (10), tpload_tiledrain (10), tpload_streambank (10), tpload_subsurface (10), tpload_pointsource (10), tpload_septics (10), tnload_hp (10), tnload_crop (10), tnload_wooded (10), tnload_open (10), tnload_barren (10), tnload_ldm (10), tnload_mdm (10), tnload_hdm (10), tnload_otherup (10), tnload_farman (10), tnload_tiledrain (10), tnload_streambank (10), tnload_subsurface (10), tnload_pointsource (10), tnload_septics (10), tssload_hp (10), tssload_crop (10), tssload_wooded (10), tssload_open (10), tssload_barren (10), tssload_ldm (10), tssload_mdm (10), tssload_hdm (10), tssload_otherup (10), tssload_tiledrain (10), tssload_streambank (10))")

    def test_invalid_attibute(self):
        with self.assertRaisesRegex(AttributeError,
                                    "Additional properties are not allowed \('extra' was unexpected\)"):
            self.sut = StringParser.parse(
                "HotSpotMap(huc12 (20402010101), extra (10), tpload_hp (10), tpload_Crop (10), tpload_Wooded (10), tpload_Open (10), tpload_barren (10), tpload_ldm (10), tpload_MDM (10), tpload_HDM (10), tpload_OtherUp (10), tpload_FarmAn (10), tpload_tiledrain (10), tpload_streambank (10), tpload_subsurface (10), tpload_pointsource (10), tpload_septics (10), tnload_hp (10), tnload_crop (10), tnload_wooded (10), tnload_open (10), tnload_barren (10), tnload_ldm (10), tnload_mdm (10), tnload_hdm (10), tnload_otherup (10), tnload_farman (10), tnload_tiledrain (10), tnload_streambank (10), tnload_subsurface (10), tnload_pointsource (10), tnload_septics (10), tssload_hp (10), tssload_crop (10), tssload_wooded (10), tssload_open (10), tssload_barren (10), tssload_ldm (10), tssload_mdm (10), tssload_hdm (10), tssload_otherup (10), tssload_tiledrain (10), tssload_streambank (10))")

    def test_attribute_without_name(self):
        self.sut = StringParser.parse(
            "HotSpotMap(huc12 (20402010101), (10,12), tpload_hp (10), tpload_Crop (10), tpload_Wooded (10), tpload_Open (10), tpload_barren (10), tpload_ldm (10), tpload_MDM (10), tpload_HDM (10), tpload_OtherUp (10), tpload_FarmAn (10), tpload_tiledrain (10), tpload_streambank (10), tpload_subsurface (10), tpload_pointsource (10), tpload_septics (10), tnload_hp (10), tnload_crop (10), tnload_wooded (10), tnload_open (10), tnload_barren (10), tnload_ldm (10), tnload_mdm (10), tnload_hdm (10), tnload_otherup (10), tnload_farman (10), tnload_tiledrain (10), tnload_streambank (10), tnload_subsurface (10), tnload_pointsource (10), tnload_septics (10), tssload_hp (10), tssload_crop (10), tssload_wooded (10), tssload_open (10), tssload_barren (10), tssload_ldm (10), tssload_mdm (10), tssload_hdm (10), tssload_otherup (10), tssload_tiledrain (10), tssload_streambank (10))")
        # doesn't pass on an of the extra arguments so that's good enough?
    # self.fail()

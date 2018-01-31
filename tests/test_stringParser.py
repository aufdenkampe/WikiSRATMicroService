from unittest import TestCase
from StringParser import StringParser


class TestStringParser(TestCase):

    def test_parse(self):
        expected = [{'huc12': "20402010101", 'tpload_hp': 10, 'tpload_Crop': 10, 'tpload_Wooded': 10, 'tpload_Open': 10,
                     'tpload_barren': 10, 'tpload_ldm': 10, 'tpload_MDM': 10, 'tpload_HDM': 10, 'tpload_OtherUp': 10,
                     'tpload_FarmAn': 10, 'tpload_tiledrain': 10, 'tpload_streambank': 10, 'tpload_subsurface': 10,
                     'tpload_pointsource': 10, 'tpload_septics': 10, 'tnload_hp': 10, 'tnload_crop': 10,
                     'tnload_wooded': 10, 'tnload_open': 10, 'tnload_barren': 10, 'tnload_ldm': 10, 'tnload_mdm': 10,
                     'tnload_hdm': 10, 'tnload_otherup': 10, 'tnload_farman': 10, 'tnload_tiledrain': 10,
                     'tnload_streambank': 10, 'tnload_subsurface': 10, 'tnload_pointsource': 10, 'tnload_septics': 10,
                     'tssload_hp': 10, 'tssload_crop': 10, 'tssload_wooded': 10, 'tssload_open': 10,
                     'tssload_barren': 10, 'tssload_ldm': 10, 'tssload_mdm': 10, 'tssload_hdm': 10,
                     'tssload_otherup': 10, 'tssload_tiledrain': 10, 'tssload_streambank': 10},
                    {'huc12': "20402010102", 'tpload_hp': 10, 'tpload_Crop': 10, 'tpload_Wooded': 10, 'tpload_Open': 10,
                     'tpload_barren': 10, 'tpload_ldm': 10, 'tpload_MDM': 10, 'tpload_HDM': 10, 'tpload_OtherUp': 10,
                     'tpload_FarmAn': 10, 'tpload_tiledrain': 10, 'tpload_streambank': 10, 'tpload_subsurface': 10,
                     'tpload_pointsource': 10, 'tpload_septics': 10, 'tnload_hp': 10, 'tnload_crop': 10,
                     'tnload_wooded': 10, 'tnload_open': 10, 'tnload_barren': 10, 'tnload_ldm': 10, 'tnload_mdm': 10,
                     'tnload_hdm': 10, 'tnload_otherup': 10, 'tnload_farman': 10, 'tnload_tiledrain': 10,
                     'tnload_streambank': 10, 'tnload_subsurface': 10, 'tnload_pointsource': 10, 'tnload_septics': 10,
                     'tssload_hp': 10, 'tssload_crop': 10, 'tssload_wooded': 10, 'tssload_open': 10,
                     'tssload_barren': 10, 'tssload_ldm': 10, 'tssload_mdm': 10, 'tssload_hdm': 10,
                     'tssload_otherup': 10, 'tssload_tiledrain': 10, 'tssload_streambank': 10},
                    {'huc12': "20402010103", 'tpload_hp': 10, 'tpload_Crop': 10, 'tpload_Wooded': 10, 'tpload_Open': 10,
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
            '[{"huc12": "20402010101", "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"huc12": "20402010102", "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"huc12": "20402010103", "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]')
        self.assertIsInstance(self.sut, list, msg="Did not return an array")
        self.assertEqual(len(self.sut), 3)
        for i in range(0, len(self.sut)):
            self.assertDictEqual(self.sut[i], expected[i], msg="Invalid huc12 data")

    # def test_check_not_a_hotspot(self):
    #     with self.assertRaises(AttributeError):
    #         self.sut = StringParser.parse("NotAHotSpotMap(ugly)")
    #         print(self.sut)
    def test_not_json(self):
        with self.assertRaisesRegex(AttributeError,
                                    "Expecting property name enclosed in double quotes: line 1 column 2 \(char 1\)"):
            self.sut = StringParser.parse("{test")

    def test_check_no_huc12(self):
        with self.assertRaisesRegex(AttributeError, "'9999999999999' does not match '\^\[0-9\]\{1,12\}\$'"):
            self.sut = StringParser.parse(
                '[{"huc12": "9999999999999", "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]')

    def test_check_not_valid_attribute(self):
        with self.assertRaisesRegex(AttributeError, "'something' is not of type 'number'"):
            self.sut = StringParser.parse(
                '[{"huc12": "20402010101", "tpload_hp": "something", "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]')

    def test_no_huc_id(self):
        with self.assertRaisesRegex(AttributeError, '\'huc12\' is a required property'):
            self.sut = StringParser.parse(
                '[{"huc12": "20402010101", "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"huc12": "20402010103", "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]')

    def test_invalid_attibute(self):
        with self.assertRaisesRegex(AttributeError,
                                    "Additional properties are not allowed \('extra' was unexpected\)"):
            self.sut = StringParser.parse(
                '[{"huc12": "20402010101", "extra": 10, "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]')

    def test_ob_to_string(self):
        self.sut = StringParser.ob_to_string(
            [{'huc12': "20402010101", 'tpload_hp': 10, 'tpload_Crop': 10, 'tpload_Wooded': 10, 'tpload_Open': 10,
              'tpload_barren': 10, 'tpload_ldm': 10, 'tpload_MDM': 10, 'tpload_HDM': 10, 'tpload_OtherUp': 10,
              'tpload_FarmAn': 10, 'tpload_tiledrain': 10, 'tpload_streambank': 10, 'tpload_subsurface': 10,
              'tpload_pointsource': 10, 'tpload_septics': 10, 'tnload_hp': 10, 'tnload_crop': 10,
              'tnload_wooded': 10, 'tnload_open': 10, 'tnload_barren': 10, 'tnload_ldm': 10, 'tnload_mdm': 10,
              'tnload_hdm': 10, 'tnload_otherup': 10, 'tnload_farman': 10, 'tnload_tiledrain': 10,
              'tnload_streambank': 10, 'tnload_subsurface': 10, 'tnload_pointsource': 10, 'tnload_septics': 10,
              'tssload_hp': 10, 'tssload_crop': 10, 'tssload_wooded': 10, 'tssload_open': 10,
              'tssload_barren': 10, 'tssload_ldm': 10, 'tssload_mdm': 10, 'tssload_hdm': 10,
              'tssload_otherup': 10, 'tssload_tiledrain': 10, 'tssload_streambank': 10}])
        self.assertEqual(self.sut,
                         '[{"huc12": "20402010101", "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]')

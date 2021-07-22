import json

class DatabaseFormatter:
    @classmethod
    def parse(self, input_dbdata):
        # TODO: Where are the tile drain inputs?
        # TODO: I do not see open space developed?
        parsed = []
        for i in range(0, len(input_dbdata)):
            _temp = {}
            _temp['huc12'] = input_dbdata[i][1]

            _temp['tpload_hp'] = float(input_dbdata[i][33])
            _temp['tpload_crop'] = float(input_dbdata[i][34])
            _temp['tpload_wooded'] = float(input_dbdata[i][35])
            _temp['tpload_open'] = float(input_dbdata[i][37])
            _temp['tpload_barren'] = float(input_dbdata[i][38])
            _temp['tpload_ldm'] = float(input_dbdata[i][39])
            _temp['tpload_mdm'] = float(input_dbdata[i][40])
            _temp['tpload_hdm'] = float(input_dbdata[i][41])
            _temp['tpload_wetland'] = float(input_dbdata[i][36])
            _temp['tpload_farman'] = float(input_dbdata[i][43])
            _temp['tpload_tiledrain'] = float(0.0)
            _temp['tpload_streambank'] = float(input_dbdata[i][44])
            _temp['tpload_subsurface'] = float(input_dbdata[i][45])
            _temp['tpload_pointsource'] = float(input_dbdata[i][46])
            _temp['tpload_septics'] = float(input_dbdata[i][47])

            _temp['tnload_hp'] = float(input_dbdata[i][18])
            _temp['tnload_crop'] = float(input_dbdata[i][19])
            _temp['tnload_wooded'] = float(input_dbdata[i][20])
            _temp['tnload_open'] = float(input_dbdata[i][22])
            _temp['tnload_barren'] = float(input_dbdata[i][23])
            _temp['tnload_ldm'] = float(input_dbdata[i][24])
            _temp['tnload_mdm'] = float(input_dbdata[i][25])
            _temp['tnload_hdm'] = float(input_dbdata[i][26])
            _temp['tnload_wetland'] = float(input_dbdata[i][21])
            _temp['tnload_farman'] = float(input_dbdata[i][28])
            _temp['tnload_tiledrain'] = float(0.0)
            _temp['tnload_streambank'] = float(input_dbdata[i][29])
            _temp['tnload_subsurface'] = float(input_dbdata[i][30])
            _temp['tnload_pointsource'] = float(input_dbdata[i][31])
            _temp['tnload_septics'] = float(input_dbdata[i][32])

            _temp['tssload_hp'] = float(input_dbdata[i][3])
            _temp['tssload_crop'] = float(input_dbdata[i][4])
            _temp['tssload_wooded'] = float(input_dbdata[i][5])
            _temp['tssload_open'] = float(input_dbdata[i][7])
            _temp['tssload_barren'] = float(input_dbdata[i][8])
            _temp['tssload_ldm'] = float(input_dbdata[i][9])
            _temp['tssload_mdm'] = float(input_dbdata[i][10])
            _temp['tssload_hdm'] = float(input_dbdata[i][11])
            _temp['tssload_wetland'] = float(input_dbdata[i][6])
            _temp['tssload_tiledrain'] = float(0.0)
            _temp['tssload_streambank'] = float(input_dbdata[i][14])
            # print(input_dbdata[i][1])
            parsed.append(json.dumps(_temp))

        return str(parsed).replace("'", "")
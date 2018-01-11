import os
from StringParser import StringParser
from DatabaseAdapter import DatabaseAdapter

test = StringParser.parse(
    '[{"huc12": 20402010101, "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"huc12": 20402010102, "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"huc12": 20402010103, "tpload_hp": 10, "tpload_Crop": 10, "tpload_Wooded": 10, "tpload_Open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_MDM": 10, "tpload_HDM": 10, "tpload_OtherUp": 10, "tpload_FarmAn": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_otherup": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_otherup": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]')

for i in range(0, len(test)):
    print(test[i])

try:
    db = os.environ['POSTGRES_DB']
    user = os.environ['POSTGRES_USER']
    host = os.environ['POSTGRES_HOST']
    port = os.environ['POSTGRES_PORT']
    password = os.environ['POSTGRES_PASSWORD']
    db = DatabaseAdapter(db, user, host, port, password)
    input_array = DatabaseAdapter.python_to_array(test)
    print(DatabaseAdapter.run_model(input_array))
except KeyError as e:
    print("Enviromnanetal variables not set (" + e.args[0] + ")")

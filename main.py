import os
from StringParser import StringParser
from DatabaseAdapter import DatabaseAdapter

parser = StringParser()
test = parser.parse(
    "HotSpotMap( huc12 (181243213421,181243213421, 441243213421) tpload_hp (123,156,1512) tssload_crop (5672,125,82435) tpload_Wooded ( 721435,1345,12435) tnload_septics (37,26,85))")

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
except KeyError as e:
    print("Enviromnanetal variables not set (" + e.args[0] + ")")

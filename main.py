import os
from StringParser import StringParser
from DatabaseAdapter import DatabaseAdapter
import json

print('Loading function')
try:
    database = os.environ['drwi']
    user = os.environ['mikec']
    host = os.environ['ans-drwi.ansp.org']
    port = os.environ['5432']
    password = os.environ['gh28bh230vg']
except KeyError as e:
    print("Enviromnanetal variables not set (" + e.args[0] + ")")


def respond(err, res=None):
    return {
        'statusCode': '400' if err else '200',
        'body': err.args[0] if err else json.dumps(res),
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
    }


def lambda_handler(event, context):
    try:
        data = StringParser.parse(event['body'])
        db = DatabaseAdapter(database, user, host, port, password)
        input_array = DatabaseAdapter.python_to_array(data)
        return respond(None, db.run_model(input_array))
    except AttributeError as e:
        return respond(e)


if __name__ == "__main__":
    print(lambda_handler({
        "body": '[{"huc12": "020402010101", "tpload_hp": 10, "tpload_crop": 10, "tpload_wooded": 10, "tpload_open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_mdm": 10, "tpload_hdm": 10, "tpload_wetland": 10, "tpload_farman": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_wetland": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_wetland": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"huc12": "20402010102", "tpload_hp": 10, "tpload_crop": 10, "tpload_wooded": 10, "tpload_open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_mdm": 10, "tpload_hdm": 10, "tpload_wetland": 10, "tpload_farman": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_wetland": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_wetland": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}, {"huc12": "20402010103", "tpload_hp": 10, "tpload_crop": 10, "tpload_wooded": 10, "tpload_open": 10, "tpload_barren": 10, "tpload_ldm": 10, "tpload_mdm": 10, "tpload_hdm": 10, "tpload_wetland": 10, "tpload_farman": 10, "tpload_tiledrain": 10, "tpload_streambank": 10, "tpload_subsurface": 10, "tpload_pointsource": 10, "tpload_septics": 10, "tnload_hp": 10, "tnload_crop": 10, "tnload_wooded": 10, "tnload_open": 10, "tnload_barren": 10, "tnload_ldm": 10, "tnload_mdm": 10, "tnload_hdm": 10, "tnload_wetland": 10, "tnload_farman": 10, "tnload_tiledrain": 10, "tnload_streambank": 10, "tnload_subsurface": 10, "tnload_pointsource": 10, "tnload_septics": 10, "tssload_hp": 10, "tssload_crop": 10, "tssload_wooded": 10, "tssload_open": 10, "tssload_barren": 10, "tssload_ldm": 10, "tssload_mdm": 10, "tssload_hdm": 10, "tssload_wetland": 10, "tssload_tiledrain": 10, "tssload_streambank": 10}]'},
        None))

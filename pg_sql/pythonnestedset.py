import psycopg2; import numpy as np;

try:
    conn = psycopg2.connect("dbname='postgres' user='postgres' host='localhost' password='vn9jz9xr'")
except:
    print ( 'I am unable to connect to the database')
    
cur = conn.cursor();
cur.execute("""select * from wikiwtershed.nhdplus_stream_nsidxprocess""");
rows = np.matrix(cur.fetchall()).astype(int);

stack = [1];

# def up(n,stack):
#     stack =
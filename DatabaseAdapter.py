import psycopg2
from constants import huc12_column_numbers
from constants import huc12_returned_column_numbers
from constants import comid_column_numbers
from constants import comid_returned_column_numbers


class DatabaseAdapter:
    def __init__(self, db_in, user_in, host_in, port_in, password_in):
        try:
            self.conn = psycopg2.connect(database=db_in, user=user_in, host=host_in, port=port_in, password=password_in)
        except psycopg2.OperationalError as e:
            raise AttributeError("unable to connect to datbase")

    @classmethod
    def python_to_array(self, python_object):
        result = []
        for _ in range(0, len(huc12_column_numbers)):  # create an array of arrays without numpy
            result.append([])
        for huc12 in python_object:
            for attribute, value in huc12.items():
                result[huc12_column_numbers[attribute]].append(value)
        return result

    @classmethod
    def huc12_array_to_python(self, array):
        result = []
        for _ in range(0, len(array)):
            result.append({})  # prep the right number of empty huc12 objects
        for i, huc12 in enumerate(array):
            for j, attribute in enumerate(huc12):
                result[i][huc12_returned_column_numbers[j]] = attribute
        return result

    @classmethod
    def comid_array_to_python(self, array):
        result = []
        for _ in range(0, len(array)):
            result.append({})  # prep the right number of empty huc12 objects
        for i, comid in enumerate(array):
            for j, attribute in enumerate(comid):
                result[i][comid_returned_column_numbers[j]] = attribute
        return result

    @classmethod
    def huc12_array_to_dictionary(self, huc12_array):
        return {str(x["huc12"]): x for x in huc12_array}

    @classmethod
    def comid_array_to_dictionary(self, comid_array):
        return {str(x["comid"]): x for x in comid_array}

    @classmethod
    def join_huc12s__and_comids_(self, huc12s, comids):
        comids_dictionary = self.comid_array_to_dictionary(comids)
        for huc12 in huc12s:
            comid_array = []
            if("catchments" in huc12 and huc12["catchments"] != None):#if this huc12 has catchments, join the data from the comid array
                for catchment in huc12["catchments"]:
                    if(catchment in comids_dictionary):
                        comid_array.append(comids_dictionary[catchment])#append to array too create array of comid data
                    else:
                        raise KeyError('comid not in table')
                huc12["catchments"] = self.comid_array_to_dictionary(comid_array)
            else:
                huc12["catchments"] = {}#otherwise catchments is just an empty dictionary
        return huc12s

    def srat_nhd(self, input_array):
        cur = self.conn.cursor()
        cur.callproc('wikiwtershed.srat_nhd', input_array)
        return self.comid_array_to_python(cur.fetchall())

    def srat_huc12(self, input_array):
        cur = self.conn.cursor()
        cur.callproc('wikiwtershed.srat_huc12', input_array)
        return self.huc12_array_to_python(cur.fetchall())

    def run_model(self, input_array):
        comids = self.srat_nhd(input_array)
        huc12s = self.srat_huc12(input_array)
        combined = self.join_huc12s__and_comids_(huc12s, comids)
        huc12s_dictionary = self.huc12_array_to_dictionary(combined)
        return {"huc12s": huc12s_dictionary}

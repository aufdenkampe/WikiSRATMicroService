from unittest import TestCase
from unittest import mock
from DatabaseAdapter import DatabaseAdapter
import psycopg2
from constants import huc12_returned_column_numbers


class TestDatabaseAdapter(TestCase):

    @mock.patch("psycopg2.connect", mock.Mock(side_effect=psycopg2.OperationalError()))
    def test_connect_failed(self):
        with self.assertRaisesRegex(AttributeError, "unable to connect to datbase"):
            self.sut = DatabaseAdapter("test", "test", "test", "test", "test")

    @mock.patch("psycopg2.connect")
    @mock.patch.dict("constants.huc12_returned_column_numbers", {0: "huc12", 1: "catchments"})
    @mock.patch.dict("constants.comid_returned_column_numbers", {0: "comid", 1: "test_header"})
    def test_run_model(self, mock_connection):
        self.sut = DatabaseAdapter("test", "test", "test", "test", "test")
        self.sut.srat_huc12 = mock.MagicMock(return_value=[{'huc12': '123', 'catchments': ["321"]}])
        self.sut.srat_nhd = mock.MagicMock(return_value=[{'comid': 321, 'test_header': 456}])
        result = self.sut.run_model([1, 2, 3, 4])
        self.assertEqual({'huc12s':
                              {'123': {'catchments': {'321': {'comid': 321, 'test_header': 456}},
                                       'huc12': '123'}}
                          }
                         , result)

    @mock.patch("psycopg2.connect")
    @mock.patch.dict("constants.huc12_returned_column_numbers", {0: "huc12", 1: "catchments"})
    @mock.patch.dict("constants.comid_returned_column_numbers", {0: "comid", 1: "test_header"})
    def test_run_model_no_catchments(self, mock_connection):
        self.sut = DatabaseAdapter("test", "test", "test", "test", "test")
        self.sut.srat_huc12 = mock.MagicMock(return_value=[{'huc12': '123', 'test_header': 321}])
        self.sut.srat_nhd = mock.MagicMock(return_value=[])
        result = self.sut.run_model([1, 2, 3, 4])
        self.assertEqual({'huc12s':
                              {'123': {'huc12': '123',
                                       'test_header': 321,
                                       'catchments': {}
                                       }}
                          }
                         , result)

    @mock.patch("psycopg2.connect")
    @mock.patch.dict("constants.huc12_returned_column_numbers", {0: "huc12", 1: "catchments"})
    def test_run_model_bad_huc12(self, mock_connect):
        self.sut = DatabaseAdapter("test", "test", "test", "test", "test")
        self.sut.srat_huc12 = mock.MagicMock(return_value=[{'huc12': '123', 'catchments': ["321"]}])
        self.sut.srat_nhd = mock.MagicMock(
            return_value=[{'comid': 456, 'test_header': 456}])  # comid 321 is missing from comid table
        with self.assertRaisesRegex(KeyError, 'comid not in table'):
            self.sut.run_model([1, 2, 3, 4])

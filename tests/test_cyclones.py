from app import APP
import unittest

class Tests(unittest.TestCase):
    def setUp(self):
        self.app = APP.test_client()

    def test_cyclones(self):
        rv = self.app.get('/05024756-765e-41a9-89d7-1407436d9a58')
        assert rv.status == '200 OK'
        assert rv.json == {"guid":"05024756-765e-41a9-89d7-1407436d9a58","latlong":"42.026111,-93.648333","location":"Ames, IA, USA","mascot":"Cy","nickname":"Cyclones","school":"Iowa State University"}

if __name__ == "__main__":
    unittest.main()

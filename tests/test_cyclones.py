import pytest
from flask import url_for

class TestApp:

    def test_cyclones(self, client):
        res = client.get('/05024756-765e-41a9-89d7-1407436d9a58')
        assert res.status_code == 200
        assert res.json == {"guid":"05024756-765e-41a9-89d7-1407436d9a58","latlong":"42.026111,-93.648333","location":"Ames, IA, USA","mascot":"Cy","nickname":"Cyclones","school":"Iowa State University"}

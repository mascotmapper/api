import pytest
from flask import url_for

class TestApp:

    def test_200(self, client):
        res = client.get()
        assert res.status_code == 200

    def test_404(self, client):
        res = client.get('/null')
        assert res.status_code == 404
        assert res.json == {"error":"404 Not Found: The requested URL was not found on the server.  If you entered the URL manually please check your spelling and try again."}

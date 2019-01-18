from app import APP
import unittest

# python -m unittest test_app

class TestMyApp(unittest.TestCase):
    def setUp(self):
        self.app = APP.test_client()

    def test_main(self):
        rv = self.app.get('/')
        assert rv.status == '200 OK'

from app import APP
import unittest

# python -m unittest test_app

class Tests(unittest.TestCase):
    def setUp(self):
        self.app = APP.test_client()

    def test_200(self):
        rv = self.app.get('/')
        assert rv.status == '200 OK'

    def test_404(self):
        rv = self.app.get('/notfound')
        assert rv.status == '404 NOT FOUND'

if __name__ == "__main__":
    unittest.main()

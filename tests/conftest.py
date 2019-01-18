import pytest
from app import APP

@pytest.fixture
def app():
    app = APP
    return app

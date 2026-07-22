import pytest

from __init__ import app


@pytest.fixture
def client():
    with app.test_client() as client:
        yield client

import pytest
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../src')))
from app import app

@pytest.fixture
def client():
    """Creates a test client using Flask's built-in test client."""
    app.testing = True
    with app.test_client() as client:
        yield client

def test_home_route(client):
    """Test if the home route returns the correct response."""
    response = client.get("/")
    assert response.status_code == 200
    assert b"Welcome to CI/CD Pipeline with Jenkins!" in response.data

def test_health_route(client):
    """Test if the health route returns a valid JSON response."""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.is_json
    assert response.get_json() == {"status": "running"}

import pytest
from app import app


@pytest.fixture
def client():
    """Créer un client de test Flask"""
    with app.test_client() as client:
        yield client


def test_homepage(client):
    """Test que la page d'accueil retourne 200 et le message attendu"""
    response = client.get("/")
    assert response.status_code == 200
    assert b"Bienvenue dans l'Atelier DevOps" in response.data


def test_exercices_page(client):
    """Test que la page /exercices/ retourne 200 et le prénom/nom"""
    response = client.get("/exercices/")
    assert response.status_code == 200
    assert b"Bernard Daniel KABOU" in response.data

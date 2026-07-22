def test_exercices_page_status_and_content(client):
    response = client.get("/exercices/")

    assert response.status_code == 200
    assert b"Bienvenue sur vote pge Web" in response.data
    assert b"Ceci est le projet de" in response.data

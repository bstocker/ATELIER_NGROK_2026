def test_exercices_page_returns_200_and_name(client):
    response = client.get("/exercices/")

    assert response.status_code == 200
    assert b"Nicolas Bellina" in response.data
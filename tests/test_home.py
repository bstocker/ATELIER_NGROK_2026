def test_home_page_returns_200_and_greeting(client):
    response = client.get("/")

    assert response.status_code == 200
    assert b"Bonjour tout le monde !" in response.data
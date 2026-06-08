def test_home_page_status_and_content(client):
    response = client.get("/")

    assert response.status_code == 200
    assert b"Bonjour tout le monde" in response.data

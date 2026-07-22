## Déploiement et Utilisation

Ce projet met à disposition des images Docker prêtes à l'emploi via GitHub Container Registry (GHCR). 
Vous n'avez pas besoin de cloner ce dépôt ni de construire l'image vous-même.

Pour récupérer et lancer la dernière version stable de l'application :

```bash
# 1. Télécharger la dernière image
docker pull ghcr.io/getill/ATELIER_DEVOPS_2026:latest

# 2. Lancer le conteneur en exposant le port 5000
docker run -p 5000:5000 ghcr.io/getill/ATELIER_DEVOPS_2026:latest
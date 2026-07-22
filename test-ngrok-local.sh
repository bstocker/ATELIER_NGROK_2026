#!/bin/bash

# Script local pour tester Ngrok avant GitHub Actions
# Usage: ./test-ngrok-local.sh

set -e

echo "🔵 Atelier DevOps - Test Ngrok Local"
echo "===================================="
echo ""

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Vérifications préalables
echo "📋 Vérifications..."

if ! command -v docker &> /dev/null; then
    echo -e "${RED}✗ Docker n'est pas installé${NC}"
    exit 1
fi

if ! command -v ngrok &> /dev/null; then
    echo -e "${YELLOW}⚠ Ngrok n'est pas dans PATH${NC}"
    echo "  Installation via pip..."
    pip install ngrok
fi

echo -e "${GREEN}✓ Toutes les dépendances sont présentes${NC}"
echo ""

# Build
echo "🔨 Construction de l'image Docker..."
docker build -t atelier-devops-app:local .
echo -e "${GREEN}✓ Build terminé${NC}"
echo ""

# Run Flask
echo "🚀 Démarrage du conteneur Flask..."
docker run -d \
    --name flask-app-local \
    -p 5000:5000 \
    atelier-devops-app:local > /dev/null
echo -e "${GREEN}✓ Conteneur démarré${NC}"

# Wait for Flask
echo "⏳ Attente du démarrage de Flask..."
for i in {1..30}; do
    if curl -f http://localhost:5000/ > /dev/null 2>&1; then
        echo -e "${GREEN}✓ Flask est prêt !${NC}"
        break
    fi
    echo "   Tentative $i/30..."
    sleep 1
done
echo ""

# Start Ngrok
echo "🌐 Démarrage du tunnel Ngrok..."
echo "  (Assurez-vous que NGROK_AUTHTOKEN est configuré: export NGROK_AUTHTOKEN=your_token)"
echo ""

# Start ngrok and capture URL
ngrok http 5000 --log=stdout > /tmp/ngrok.log 2>&1 &
NGROK_PID=$!

sleep 3

# Extract URL
PUBLIC_URL=$(grep -oP 'url=\K[^ ]+' /tmp/ngrok.log 2>/dev/null || echo "")
if [ -z "$PUBLIC_URL" ]; then
    PUBLIC_URL=$(grep -oP 'https://[a-zA-Z0-9-]+\.ngrok.*\.app' /tmp/ngrok.log 2>/dev/null || echo "")
fi

echo "=========================================="
if [ -n "$PUBLIC_URL" ]; then
    echo -e "${GREEN}✓ URL PUBLIQUE: $PUBLIC_URL${NC}"
    echo "=========================================="
    echo ""
    echo "🔗 Accès:"
    echo "   Page d'accueil: $PUBLIC_URL"
    echo "   Exercices:      $PUBLIC_URL/exercices/"
    echo ""
    echo "🖥  Interface Ngrok: http://127.0.0.1:4040"
    echo ""
    echo "⏱  Le tunnel restera actif pendant ~60 secondes..."
    echo "=========================================="
    
    # Keep tunnel open
    sleep 60
else
    echo -e "${RED}✗ Impossible d'extraire l'URL Ngrok${NC}"
    cat /tmp/ngrok.log
fi

echo ""
echo "🛑 Fermeture du tunnel..."
kill $NGROK_PID 2>/dev/null || true

echo "🛑 Arrêt du conteneur..."
docker stop flask-app-local > /dev/null 2>&1 || true
docker rm flask-app-local > /dev/null 2>&1 || true

echo -e "${GREEN}✓ Nettoyage terminé${NC}"
echo ""
echo "💡 Prochaines étapes:"
echo "   1. Mettez à jour templates/exercices.html avec votre nom"
echo "   2. Configurez le secret GitHub: Settings > Secrets > NGROK_AUTHTOKEN"
echo "   3. Poussez vers main et vérifiez les logs du workflow"

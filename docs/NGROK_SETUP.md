# Configuration Ngrok pour GitHub Actions

## 📋 Prérequis

1. **Compte Ngrok** : https://ngrok.com/signup
2. **AuthToken** : https://dashboard.ngrok.com/auth/your-authtoken

## 🔧 Configuration du Secret GitHub

### Étape 1: Copier ton AuthToken Ngrok
- Va sur https://dashboard.ngrok.com/auth/your-authtoken
- Copie ton token (commence par `ngrok_...`)

### Étape 2: Ajouter le secret dans GitHub
1. Va sur **Settings** > **Secrets and variables** > **Actions**
2. Clique **New repository secret**
3. Nom: `NGROK_AUTHTOKEN`
4. Valeur: Colle ton token
5. Clique **Add secret**

### Étape 3: Vérifier
Le workflow utilisera automatiquement ce secret. Tu ne le verras **jamais** en clair dans les logs.

---

## 🚀 Tester localement avant de pusher

```bash
# Rendre le script exécutable
chmod +x test-ngrok-local.sh

# Configurer ton token localement (optionnel, pour test)
export NGROK_AUTHTOKEN=your_token_here

# Lancer le test
./test-ngrok-local.sh
```

---

## 📊 Comprendre le workflow

**Fichier**: `.github/workflows/deploy.yml`

**Déclenché sur**: Chaque `push` vers `main` ou `develop`

**Étapes**:
1. Build l'image Docker
2. Lance le conteneur Flask sur le port 5000
3. Installe Ngrok CLI
4. Démarre le tunnel Ngrok
5. **Affiche l'URL publique dans les logs** ✅
6. Maintient le tunnel ouvert ~120 secondes
7. Arrête proprement le conteneur

---

## ⚠️ Dépannage

### "URL not found" dans les logs
- Vérifier que `NGROK_AUTHTOKEN` est correctement configuré
- Vérifier que ton compte Ngrok n'a pas atteint la limite de tunnels gratuits

### "Connection refused"
- Flask n'a pas démarré à temps
- Vérifier les logs Docker: `docker logs flask-app-local`

### "ngrok: command not found"
- Le binaire Ngrok n'est pas téléchargé
- Vérifier la connexion Internet du runner GitHub Actions

---

## 🎯 Critères de validation (exercice)

✅ Voir une URL au format `https://*.ngrok-free.app/` dans les logs  
✅ Pouvoir cliquer et accéder à la page d'accueil Flask  
✅ Naviguer vers `/exercices/` et voir ton prénom + nom  
✅ Job terminé proprement (pas de timeout)  
✅ Token Ngrok **jamais** visible en clair

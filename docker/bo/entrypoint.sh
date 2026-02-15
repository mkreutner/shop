#!/bin/bash
set -e

export TERM=dump
export NO_COLORS=1

if [ ! -f "package.json" ]; then
  echo "📦 Dossier vide, création du projet Vite (React-TS)..."

  sudo npm install -g npm@11.10.0
  npm create vite@8.3.0 test -- --yes --template react-ts

  echo "✅ Projet créé avec succès."

  echo "📥 Installation des dépendances (sois patient)..."
  yarn install
fi

# 2. Si package.json existe mais pas les modules (volume fraîchement monté)
if [ ! -d "node_modules" ] || [ -z "$(ls -A node_modules)" ]; then
  echo "📦 Installation des dépendances manquantes..."
  yarn install
fi

# 3. Ajustement de la config Vite pour Docker (Host & Port)
# On s'assure que Vite écoute sur toutes les interfaces (0.0.0.0)
if [ -f "package.json" ]; then
  echo "🔧 Configuration du host pour Docker..."
  sed -i 's/"dev": "vite"/"dev": "vite --host 0.0.0.0 --port 3000"/' package.json
fi

echo "🚀 Démarrage du conteneur..."
# L'exec "$@" va exécuter la commande définie dans le CMD du Dockerfile (ex: yarn dev)
exec "$@"

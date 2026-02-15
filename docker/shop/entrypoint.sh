#!/bin/sh
set -e

# Si le dossier node_modules est vide (premier lancement ou nouveau volume)
if [ ! -d "node_modules" ] || [ -z "$(ls -A node_modules)" ]; then
  echo "📦 Installation des dépendances..."
  npm install
fi

# On lance la commande passée au conteneur (npm run dev)
exec "$@"

#!/bin/bash

DOCKER_COMPOSE_CMD="$(which docker) compose"

# Chargement des variables .env
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "❌ Erreur: Fichier .env manquant. Copiez .env.sample en .env"
  exit 1
fi

echo "🏗️  Construction des images avec les Dockerfile.dev et lancement des containers..."
${DOCKER_COMPOSE_CMD} build
echo ">>> Intall bo"
${DOCKER_COMPOSE_CMD} run --rm bo
echo ">>> Intall shop"
${DOCKER_COMPOSE_CMD} run --rm shop

echo "⚙️  Configuration automatique de la DB Laravel..."
# On utilise 'sed' pour modifier le .env généré par Laravel
#touch src/api/.env
#sed -i "s/DB_CONNECTION=sqlite/DB_CONNECTION=pgsql/" src/api/.env
#sed -i "s/DB_HOST=127.0.0.1/DB_HOST=db/" src/api/.env
#sed -i "s/DB_PORT=5432/DB_PORT=5432/" src/api/.env
#sed -i "s/DB_DATABASE=laravel/DB_DATABASE=${DB_NAME}/" src/api/.env
#sed -i "s/DB_USERNAME=root/DB_USERNAME=${DB_USER}/" src/api/.env
#sed -i "s/DB_PASSWORD=/DB_PASSWORD=${DB_PASSWORD}/" src/api/.env
# On commente la ligne DB_DATABASE sqlite si elle existe
#sed -i "s/^DB_DATABASE=/#DB_DATABASE=/" src/api/.env

echo "✅ Terminé ! Vous pouvez lancer : ${DOCKER_COMPOSE_CMD} up"

#!/bin/sh
set -e

if [ ! -f "package.json" ]; then
  echo "📦 Dossier vide, création du projet api (PHP Laravel)..."
  composer create-project laravel/laravel .
fi

# 1. Installation des dépendances si le dossier vendor est absent
if [ ! -d "vendor" ]; then
  echo "🐘 Installation de Composer..."
  composer install --no-interaction --optimize-autoloader
fi

# 2. Permissions vitales pour Laravel
# On s'assure que storage et bootstrap/cache sont scriptables
echo "🔐 Fix des permissions storage..."
chmod -R 775 storage bootstrap/cache

# 3. Attente de la base de données avant de lancer les migrations
echo "⏳ Attente de la base de données..."
# Cette commande simple vérifie si MySQL répond sur le port 3306
#until nc -z db 5436; do
#  sleep 1
#done

# 4. Migrations (si le projet est vide)
php artisan migrate --force

php artisan serve --host 0.0.0.0 --port 8000

exec "$@"

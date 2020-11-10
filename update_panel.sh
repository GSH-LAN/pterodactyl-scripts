#!/bin/bash

LATEST_VERSION=$(curl -s https://api.github.com/repos/pterodactyl/panel/releases/latest | grep tag_name | cut -d '"' -f 4 | cut -c 2-)
CURRENT_VERSION=$(sed -nE "s/^\s*'version' => '(.*?)',$/\1/p" /var/www/html/pterodactyl/config/app.php)

if [ "$CURRENT_VERSION" != "$LATEST_VERSION" ]; then
	cd /var/www/html/pterodactyl/
	php artisan down
	curl -L https://github.com/pterodactyl/panel/releases/download/v$LATEST_VERSION/panel.tar.gz | tar -xzv
	chmod -R 755 storage/* bootstrap/cache
	composer install --no-dev --optimize-autoloader
	php artisan view:clear
	php artisan config:clear
	php artisan migrate --seed --force
	chown -R www-data:www-data *
	php artisan queue:restart
	php artisan up

fi

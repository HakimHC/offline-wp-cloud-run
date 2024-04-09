#! /bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp config create \
	 --dbname=$DB_DATABASE \
	  --dbuser=$DB_USER \
	  --dbpass=$DB_PASSWORD \
	  --dbhost=$DB_HOST


echo "define('FORCE_SSL_ADMIN', true);" >> wp-config.php
echo "define('WP_HOME', 'https://' . $_SERVER['HTTP_HOST']);" >> wp-config.php
echo "$_SERVER['HTTPS'] = 'on';" >> wp-config.php
echo "$_SERVER['SERVER_PORT'] = 443;" >> wp-config.php

exec apache2-foreground


#! /bin/bash

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

cp /wp-config.php .

# wp config create \
# 	 --dbname=$DB_DATABASE \
# 	  --dbuser=$DB_USER \
# 	  --dbpass=$DB_PASSWORD \
# 	  --dbhost=$DB_HOST \
# 	  --allow-root


exec apache2-foreground


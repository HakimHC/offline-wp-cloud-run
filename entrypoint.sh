#! /bin/bash

set -e

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# if ! $(wp core is-installed --allow-root); then
#     wp core install --url="$WORDPRESS_SITE_URL" --title="$WORDPRESS_SITE_TITLE" \
#         --admin_user="$WORDPRESS_ADMIN_USER" --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
#         --admin_email="$WORDPRESS_ADMIN_EMAIL" --allow-root
# fi

exec "$@"

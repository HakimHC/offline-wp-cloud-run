#! /bin/bash

wp theme activate --allow-root twentytwentythree
wp plugin install --allow-root --activate simply-static
wp plugin install --allow-root --activate /simply-static-pro.zip

chmod -R 755 /var/www/html/wp-content/uploads
chown -R nobody:nogroup /var/www/html/wp-content/uploads

chmod -R 777 /var/www/html/wp-content/uploads/simply-static
chown -R www-data:www-data /var/www/html/wp-content/uploads/simply-static/

exec apache2-foreground

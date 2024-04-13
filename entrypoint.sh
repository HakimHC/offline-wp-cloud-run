#! /bin/bash

gcloud run services list

wp theme activate --allow-root twentytwentythree
wp plugin install --allow-root --activate simply-static
wp plugin install --allow-root --activate /simply-static-pro.zip

chmod -R 755 /var/www/html/wp-content/uploads/simply-static
chown -R www-data:www-data /var/www/html/wp-content/uploads/simply-static/

echo "add_filter( 'ssp_single_auto_export','__return_true' );" >> wp-includes/functions.php

echo "define( 'SSP_GITHUB', [
	'github-personal-access-token' => '$SSP_GITHUB_TOKEN',
	'github-user'                  => '$SSP_GITHUB_USER',
	'github-repository'            => '$SSP_GITHUB_REPO',
	'github-branch'                => '$SSP_GITHUB_BRANCH'
] );" >> wp-config.php

exec apache2-foreground

#! /bin/bash

get_cloud_run_domain_name() {
	curl \
	-d "{\"service_name\": \"$SERVICE_NAME\"}" \
	-H "Content-Type: application/json" \
	"$DOMAIN_FUNCTION_URL" | jq -r ".service_url"
}
curl \
-d "{\"service_name\": \"$SERVICE_NAME\"}" \
-H "Content-Type: application/json" \
"$DOMAIN_FUNCTION_URL"

domain_name="$(get_cloud_run_domain_name)"

echo "DOMAIN NAME: '${domain_name}'"|cat -A

domain_name="$(echo -e "${domain_name}" | tr -d '[:space:]')"

wp core install --allow-root \
	--url="${domain_name%?}" \
	--title="Altostratus Wordpress Blog" \
	--admin_user="admin" \
	--admin_email="admin@bootcamp.altostratus.es"

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

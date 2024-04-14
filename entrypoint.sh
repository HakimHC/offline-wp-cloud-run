#! /bin/bash

metadata_token_url="http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/token"

get_auth_token() {
	curl \
	-H "Metadata-Flavor: Google" \
	$metadata_token_url | jq -r ".access_token" | tr -d "\n"
}

echo "TOKEN: $(get_auth_token)"

get_cloud_run_domain_name() {
	curl \
	-d "{\"service_name\": \"$SERVICE_NAME\"}" \
	-H "Content-Type: application/json" \
	-H "Authorization: Bearer $(get_auth_token)" \
	"$DOMAIN_FUNCTION_URL" | jq -r ".service_url" | tr -d "\n"
}

domain_name="$(get_cloud_run_domain_name)"

# CONDITION HERE

wp core install --allow-root --url=$domain_name --title="Altostratus Wordpress Blog" \
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
] );"

exec apache2-foreground

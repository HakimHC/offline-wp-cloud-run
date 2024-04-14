#! /bin/bash

metadata_token_url="http://metadata.google.internal/computeMetadata/v1/instance/service-accounts/default/identity?audience=$DOMAIN_FUNCTION_URL"

get_auth_token() {
	curl \
	-H "Metadata-Flavor: Google" \
	$metadata_token_url
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

echo "DOMAIN NAME: $domain_name"

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

echo "function add_custom_http_header(\$r, \$url) {
    \$r['headers']['Authorization'] = 'Bearer $(get_auth_token)';
    return \$r;
}
add_filter('http_request_args', 'add_custom_http_header', 10, 2);" >> wp-config.php


exec apache2-foreground

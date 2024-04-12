#! /bin/bash

wp theme activate --allow-root twentytwentythree
wp plugin install --allow-root --activate /simply-static-pro.zip

exec apache2-foreground

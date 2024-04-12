#! /bin/bash

wp theme activate --allow-root twentytwentythree

exec apache2-foreground

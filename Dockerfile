FROM wordpress:latest

RUN apt-get update && apt-get install -y default-mysql-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN wp core download --allow-root


COPY wp-config.php /var/www/html/wp-config.php

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]

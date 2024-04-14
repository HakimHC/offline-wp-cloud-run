FROM wordpress:latest

WORKDIR /var/www/html

COPY simply-static-pro.zip /

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

RUN apt-get update && apt-get install -y jq

COPY wp-config.php ./wp-config.php

COPY wp-docker-entrypoint.sh /wp-docker-entrypoint.sh
RUN chmod +x /wp-docker-entrypoint.sh

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/wp-docker-entrypoint.sh"]
CMD ["/entrypoint.sh"]


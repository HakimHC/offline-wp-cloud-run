FROM wordpress:latest

RUN apt-get update && apt-get install -y default-mysql-client

COPY wp-config.php /var/www/html/wp-config.php

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]

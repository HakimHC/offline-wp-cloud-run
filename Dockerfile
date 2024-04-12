FROM wordpress:latest

WORKDIR /usr/src/wordpres

RUN apt-get update && apt-get install -y default-mysql-client

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

COPY wp-config.php /usr/src/wordpress/wp-config.php

#RUN wp core download --allow-root 
#RUN wp theme install --allow-root --activate twentytwentyone



# COPY entrypoint.sh /entrypoint.sh
# RUN chmod +x /entrypoint.sh
# 
# ENTRYPOINT ["/entrypoint.sh"]
# CMD ["apache2-foreground"]


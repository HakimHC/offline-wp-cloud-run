FROM wordpress:latest

WORKDIR /var/www/html

COPY wp-config.php .

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp


COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY d.sh /usr/local/bin/d.sh
RUN chmod +x /usr/local/bin/d.sh

ENTRYPOINT ["/usr/local/bin/d.sh"]
CMD ["/entrypoint.sh"]


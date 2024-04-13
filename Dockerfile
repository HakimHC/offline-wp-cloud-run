FROM wordpress:latest

WORKDIR /var/www/html

COPY simply-static-pro.zip /


# ================== INSTALL GCLOUD ========================
#RUN apt-get update && apt-get install -y python3
#RUN curl -sSL https://sdk.cloud.google.com | bash
#ENV PATH="$PATH:/root/google-cloud-sdk/bin"
# ==========================================================

COPY wp-config.php ./wp-config.php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp


COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY wp-docker-entrypoint.sh /wp-docker-entrypoint.sh
RUN chmod +x /wp-docker-entrypoint.sh

ENTRYPOINT ["/wp-docker-entrypoint.sh"]
CMD ["/entrypoint.sh"]


# FROM nginx:latest
#
# RUN sed -i "s/80/8080/g" /etc/nginx/conf.d/default.conf
#
# ENV A=k

# FROM adminer:standalone
#
# ENV ADMINER_DEFAULT_SERVER=mysql
# EXPOSE 8080
#
# CMD ["php", "-S", "[::]:8080", "-t", "/var/www/html"]
#

# FROM wordpress:latest
#
# EXPOSE 80
#

FROM wordpress:latest

COPY custom-entrypoint.sh .

RUN chmod +x custom-entrypoint.sh

CMD ["./custom-entrypoint.sh"]

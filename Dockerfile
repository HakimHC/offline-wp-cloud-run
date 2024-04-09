# FROM nginx:latest
#
# RUN sed -i "s/80/8080/g" /etc/nginx/conf.d/default.conf
#
# ENV A=k

FROM adminer:standalone

ENV ADMINER_DEFAULT_SERVER=mysql
EXPOSE 8080

CMD ["php", "-S", "[::]:8080", "-t", "/var/www/html"]


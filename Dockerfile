FROM nginx:latest

RUN sed -i "s/80/8080/g" /etc/nginx/conf.d/default.conf


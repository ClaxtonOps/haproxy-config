FROM nginx:1.18.0-alpine

RUN echo "nginx1" > /etc/hostname && echo "$HOSTNAME" > /var/www/html/index.html

EXPOSE 80
FROM haproxy:2.4

COPY ./haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

EXPOSE 80

#docker compose run --rm certbot certonly --webroot -w /var/www/certbot -d claxtonopslab.cloud --non-interactive --agree-tos --email paulo.odbcontato@gmail.com

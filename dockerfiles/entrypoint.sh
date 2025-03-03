#!/bin/bash
set -e  # Faz o script falhar se qualquer comando falhar

# Inicia o HAProxy em segundo plano
haproxy -f /usr/local/etc/haproxy/haproxy-dev.cfg &
HAPROXY_PID=$!

# Aguarda o HAProxy ficar pronto
sleep 10

# Gera os certificados com o Certbot
certbot certonly \
    --standalone \
    --keep-until-expiring \
    --http-01-port 63443 \
    --non-interactive \
    --agree-tos \
    --email paulo.odbcontato@gmail.com \
    -d claxtonopslab.cloud 

# Verifica se os arquivos do Certbot foram gerados
if [[ -f "/etc/letsencrypt/live/claxtonopslab.cloud/fullchain.pem" && -f "/etc/letsencrypt/live/claxtonopslab.cloud/privkey.pem" ]]; then
    # Concatena os certificados
    cat /etc/letsencrypt/live/claxtonopslab.cloud/fullchain.pem \
        /etc/letsencrypt/live/claxtonopslab.cloud/privkey.pem \
        > /usr/local/etc/haproxy/ssl/haproxy.pem

    # Define permissões seguras
    chmod 600 /usr/local/etc/haproxy/ssl/haproxy.pem
else
    echo "Erro: Certificados não foram gerados corretamente!"
    exit 1
fi

# Faz reload seguro do HAProxy
haproxy -f /usr/local/etc/haproxy/haproxy.cfg -sf "$HAPROXY_PID"

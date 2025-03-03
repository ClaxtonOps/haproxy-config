FROM haproxy:2.4

# Atualiza os pacotes e instala o Certbot
RUN apt-get update && apt-get install -y --no-install-recommends \
    certbot curl wget vim \
    && rm -rf /var/lib/apt/lists/*

# Criar diretório para os certificados
RUN mkdir -p /usr/local/etc/haproxy/ssl

# Gerar o certificado com o Certbot
RUN certbot certonly \
    --standalone \
    --keep-until-expiring \
    --http-01-port 80 \
    --non-interactive \
    --agree-tos \
    --email paulo.odbcontato@gmail.com \
    -d claxtonopslab.cloud 

# Concatenar fullchain.pem + privkey.pem e criar haproxy.pem
RUN cat /etc/letsencrypt/live/claxtonopslab.cloud/fullchain.pem \
        /etc/letsencrypt/live/claxtonopslab.cloud/privkey.pem \
        > /usr/local/etc/haproxy/ssl/haproxy.pem

# Definir permissões seguras para o arquivo do certificado
RUN chmod 600 /usr/local/etc/haproxy/ssl/haproxy.pem

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
EXPOSE 80 443

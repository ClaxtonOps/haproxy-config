FROM haproxy:2.4

# Atualiza os pacotes e instala o HAProxy
RUN apt-get update && apt-get install -y --no-install-recommends \
    certbot curl wget vim \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 80 443

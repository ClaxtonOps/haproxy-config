FROM debian:bullseye-slim

# Atualiza os pacotes e instala o HAProxy
RUN apt-get update && apt-get install -y --no-install-recommends \
    haproxy curl wget vim \
    && rm -rf /var/lib/apt/lists/*

# Cria o diretório de configuração

# Expõe as portas 80 e 443
EXPOSE 80 443

# Define o comando de entrada
CMD ["haproxy", "-f", "/etc/haproxy/haproxy.cfg"]
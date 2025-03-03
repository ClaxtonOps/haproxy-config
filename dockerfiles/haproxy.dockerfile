FROM haproxy:2.3

# Atualiza os pacotes e instala o Certbot
RUN apt-get update && apt-get install -y --no-install-recommends \
    certbot curl wget vim procps \
    && rm -rf /var/lib/apt/lists/*

COPY /haproxy/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

# Criar diretório para os certificados
RUN mkdir -p /usr/local/etc/haproxy/ssl

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
#CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
EXPOSE 80 443

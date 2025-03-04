FROM haproxy:2.3

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl wget vim procps \
    && rm -rf /var/lib/apt/lists/*

COPY /haproxy/haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

# Criar diretório para os certificados
RUN mkdir -p /usr/local/etc/haproxy/ssl

CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
EXPOSE 80 443

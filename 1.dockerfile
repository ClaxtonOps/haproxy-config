FROM nginx:latest

RUN echo "<h1>IP do Container: 192.168.100.20</h1>" > /usr/share/nginx/html/index.html

EXPOSE 80
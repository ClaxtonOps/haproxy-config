FROM nginx:latest

RUN echo "<h1>IP do Container: $(hostname -I | awk '{print $1}') </h1>" > /usr/share/nginx/html/index.html

EXPOSE 80
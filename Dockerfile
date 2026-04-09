# ETAP 1
FROM scratch AS builder

# Dodajemy system plików Alpine Linux do etapu budowania
ADD alpine-minirootfs-3.23.3-x86_64.tar /

# Deklaracja zmiennej ARG
ARG VERSION="1.0.0"

# Skrypt startowy dla Nginxa

RUN echo '#!/bin/sh' > /app.sh && \
    echo 'echo "<!DOCTYPE html><html><head><meta charset=\"UTF-8\"><title>Zadanie Lab 5</title></head><body>" > /usr/share/nginx/html/index.html' >> /app.sh && \
    echo 'echo "<h1>Aplikacja Webowa - Lab 5</h1>" >> /usr/share/nginx/html/index.html' >> /app.sh && \
    echo 'echo "<p><strong>Wersja aplikacji:</strong> '${VERSION}'</p>" >> /usr/share/nginx/html/index.html' >> /app.sh && \
    echo 'echo "<p><strong>Adres IP serwera:</strong> $(hostname -i)</p>" >> /usr/share/nginx/html/index.html' >> /app.sh && \
    echo 'echo "<p><strong>Nazwa serwera (hostname):</strong> $(hostname)</p>" >> /usr/share/nginx/html/index.html' >> /app.sh && \
    echo 'echo "</body></html>" >> /usr/share/nginx/html/index.html' >> /app.sh && \
    echo 'exec nginx -g "daemon off;"' >> /app.sh && \
    chmod +x /app.sh


# ETAP 2 
# Obraz bazowy Nginx 
FROM nginx:alpine

# Kopiowanie skryptu startowego z etapu 1
COPY --from=builder /app.sh /app.sh

# Sprawdzanie poprawności działania 
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

# Skrypt - domyślne polecenie uruchamiane przy starcie kontenera
CMD ["/app.sh"]
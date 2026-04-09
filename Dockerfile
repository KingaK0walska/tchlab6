# syntax=docker/dockerfile:1

#  Pobranie repozytorium przez protokół SSH

FROM alpine AS cloner

RUN apk add --no-cache git openssh-client

# github jako znany host, aby uniknąć problemów z autentykacją
RUN mkdir -p -m 0700 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh git clone git@github.com:KingaK0walska/tchlab6.git /pobrane_repo

# ETAP 1: Budowanie aplikacji 
FROM scratch AS builder
ADD alpine-minirootfs-3.23.3-x86_64.tar /

ARG VERSION="1.0.0"

RUN cat <<EOF > /app.sh
#!/bin/sh
mkdir -p /usr/share/nginx/html
cat <<HTML > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Zadanie Lab 6</title></head>
<body>
    <h1>Aplikacja Webowa - Lab 6 (BuildKit & SSH)</h1>
    <p><strong>Wersja aplikacji:</strong> ${VERSION}</p>
    <p><strong>Adres IP:</strong> \$(hostname -i)</p>
    <p><strong>Hostname:</strong> \$(hostname)</p>
</body>
</html>
HTML
exec nginx -g "daemon off;"
EOF

RUN chmod +x /app.sh

# Kopia pliku README.md z pobranego repozytorium!
COPY --from=cloner /pobrane_repo/README.md /usr/share/nginx/html/README.md

# Serwer docelowy 
FROM nginx:alpine
COPY --from=builder /app.sh /app.sh
# Kopiujemy plik README na serwer docelowy, aby dało się go wyświetlić w przeglądarce
COPY --from=builder /usr/share/nginx/html/README.md /usr/share/nginx/html/README.md

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://localhost/ || exit 1

CMD ["/app.sh"]
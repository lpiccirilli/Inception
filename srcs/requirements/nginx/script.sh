#!/bin/bash

mkdir -p /etc/nginx/certs

openssl genpkey -algorithm RSA -out "/etc/nginx/certs/privkey.pem" -pkeyopt rsa_keygen_bits:2048

openssl req -new -x509 -key "/etc/nginx/certs/privkey.pem" \
    -out "/etc/nginx/certs/fullchain.pem" -days 365 \
    -subj "/C=US/ST=State/L=City/O=Org/OU=OrgUnit/CN=lpicciri.42.fr"

exec nginx -g "daemon off;"

#!/bin/bash
set -e

# Create certificate directory
mkdir -p /etc/nginx/certs

# Generate private key
openssl genpkey -algorithm RSA -out "/etc/nginx/certs/privkey.pem" -pkeyopt rsa_keygen_bits:2048

# Generate self-signed certificate (valid 1 year)
openssl req -new -x509 -key "/etc/nginx/certs/privkey.pem" \
    -out "/etc/nginx/certs/fullchain.pem" -days 365 \
    -subj "/C=US/ST=State/L=City/O=Org/OU=OrgUnit/CN=lpicciri.42.fr"

exec nginx -g "daemon off;"

#!/bin/sh

# Run on server: Create custom CA

# Create the CA
openssl genrsa -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -subj "/C=ES/ST=es" -sha256 -days 1024 -out rootCA.crt

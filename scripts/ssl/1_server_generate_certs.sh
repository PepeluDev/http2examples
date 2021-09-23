#!/bin/sh

# Run on server: Create cryptographic material

# apk add openssl ca-certificates

# Create the CA
openssl genrsa -out rootCA.key 4096
openssl req -x509 -new -nodes -key rootCA.key -subj "/C=ES/ST=es" -sha256 -days 1024 -out rootCA.crt

# Generate myhttp2server cryptographic material
openssl genrsa -out myhttp2server.key 2048
openssl req -new -sha256 -key myhttp2server.key -subj "/C=ES/ST=es/O=MyOrg, Inc./CN=myhttp2server" -out myhttp2server.csr
# Verify the csr's content
openssl req -in myhttp2server.csr -noout -text

# Generate the certificate using the mydomain csr and key along with the CA Root key
openssl x509 -req -in myhttp2server.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out myhttp2server.crt -days 500 -sha256

# Verify the certificate's content
openssl x509 -in myhttp2server.crt -text -noout


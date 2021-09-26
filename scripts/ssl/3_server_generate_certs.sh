#!/bin/sh

# Create the servers certs and cryptographic material

for server in "$@"
do
    echo " cert"
    # Generate myhttp2server cryptographic material
    openssl genrsa -out ${server}.key 2048
    openssl req -new -sha256 -key ${server}.key -subj "/C=ES/ST=es/O=MyOrg, Inc./CN=${server}" -out ${server}.csr
    # Verify the csr's content
    openssl req -in ${server}.csr -noout -text

    # Generate the certificate using the mydomain csr and key along with the CA Root key
    openssl x509 -req -in ${server}.csr -CA rootCA.crt -CAkey rootCA.key -CAcreateserial -out ${server}.crt -days 500 -sha256

    # Verify the certificate's content
    openssl x509 -in ${server}.crt -text -noout

    # Delete .csr
    rm ${server}.csr
done
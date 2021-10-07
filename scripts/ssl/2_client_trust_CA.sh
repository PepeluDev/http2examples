#!/bin/sh

apk add ca-certificates

# Run on Client: Make the container trust the custom CA
cp rootCA.crt  /usr/local/share/ca-certificates/rootCA.crt
update-ca-certificates
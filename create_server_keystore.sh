#!/usr/bin/env bash

mkdir -p server/
cd server/
echo "Setting-up key, certificate and PKCS12 keystore for Server"

# Generate a private RSA key for server
openssl genrsa -out serverCA.key 2048

# Create a x509 certificate for server
openssl req -x509 -new -nodes -key serverCA.key \
    -sha256 -days 1024 -out serverCA.pem

# Create a PKCS12 keystore from private key and public certificate
# password: server
openssl pkcs12 -export -name server-cert \
    -in serverCA.pem -inkey serverCA.key \
    -out server_keystore.p12

sleep 3

echo
ls -larth
echo

# Confirm the server-certificate in PKCS12 truststore
echo "Printing content of Server truststore (user password: server)"
keytool -keystore server_keystore.p12 -list 

echo "Created key, certificate and PKCS12 keystore for Server"


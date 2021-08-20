#!/usr/bin/env bash

mkdir -p client/
cd client/
echo "Setting-up key, certificate and PKCS12 keystore for Client"

# Generate a private RSA key for client
openssl genrsa -out client_CA.key 2048

# Create a x509 certificate for client
openssl req -x509 -new -nodes -key client_CA.key \
    -sha256 -days 1024 -out client_CA.pem

# Create a PKCS12 keystore from private key and public certificate
# password: client
openssl pkcs12 -export -name client-cert \
    -in client_CA.pem -inkey client_CA.key \
    -out client_keystore.p12

sleep 3

echo
ls -larth
echo

# Confirm the client-certificate in PKCS12 truststore
echo "Printing content of Client truststore (user password: client)"
keytool -keystore client_keystore.p12 -list

echo "Created key, certificate and PKCS12 keystore for Client"


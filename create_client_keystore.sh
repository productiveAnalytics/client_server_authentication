#!/usr/bin/env bash

CLIENT_KEY_STORE_PKCS12="client_keystore.p12"

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
    -out ${CLIENT_KEY_STORE_PKCS12}

# Convert PKCS12 keystore into a JKS keystore
echo "Note: Prefer to use openssl based PKCS12, instead of JKS (user password: client)"
keytool -importkeystore -destkeystore client_keystore.jks \
    -srckeystore ${CLIENT_KEY_STORE_PKCS12} -srcstoretype pkcs12 
    -alias client-cert
echo "Imported PKCS12 to JKS keystore..."
keytool -keystore client_keystore.jks -list
sleep 3

echo
ls -larth
echo

# Confirm the client-certificate in PKCS12 truststore
echo "Printing content of Client truststore (user password: client)"
keytool -keystore ${CLIENT_KEY_STORE_PKCS12} -list

echo "Created key, certificate and PKCS12 keystore for Client"


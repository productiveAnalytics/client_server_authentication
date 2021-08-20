#!/usr/bin/env bash

SERVER_KEY_STORE_PKCS12="server_keystore.p12"

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
    -out ${SERVER_KEY_STORE_PKCS12}

# Convert PKCS12 keystore into a JKS keystore
echo "Note: Prefer to use openssl based PKCS12, instead of JKS (user password: server)"
keytool -importkeystore -destkeystore server_keystore.jks \
    -srckeystore ${SERVER_KEY_STORE_PKCS12} -srcstoretype pkcs12 
    -alias server-cert
echo "Imported server-side PKCS12 to JKS keystore..."
keytool -keystore server_keystore.jks -list 

sleep 3

echo
ls -larth
echo

# Confirm the server-certificate in PKCS12 truststore
echo "Printing content of Server truststore (user password: server)"
keytool -keystore ${SERVER_KEY_STORE_PKCS12} -list 

echo "Created key, certificate and PKCS12 keystore for Server"


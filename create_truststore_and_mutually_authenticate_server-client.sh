#!/usr/bin/env bash

SERVER_TRUST_STORE="server/server.truststore"
echo "Ready to set-up ${SERVER_TRUST_STORE} (use password: server_truststore)"

# Import a client's certificate to the server's trust store
keytool -import -alias client-cert \
    -file client/client_CA.pem -keystore ${SERVER_TRUST_STORE}

# Import a server's certificate to the server's trust store
keytool -import -alias server-cert \
    -file server/serverCA.pem -keystore ${SERVER_TRUST_STORE}

echo "Imported client-cert and server-cert in Server TrustStore: ${SERVER_TRUST_STORE}"
echo "Confirming Server-side truststore...(use password: server_truststore)"
keytool -keystore ${SERVER_TRUST_STORE} -list

echo
echo '---'
echo

CLIENT_TRUST_STORE="client/client.truststore"
echo "Ready to set-up ${CLIENT_TRUST_STORE} (use password: client_truststore)"

# Import a server's certificate to the client's trust store
keytool -import -alias server-cert \
    -file server/serverCA.pem -keystore ${CLIENT_TRUST_STORE}

# Import a client's certificate to the client's trust store
keytool -import -alias client-cert \
    -file client/client_CA.pem -keystore ${CLIENT_TRUST_STORE}

echo "Imported server-cert and client-cert in Client TrustStore: ${CLIENT_TRUST_STORE}"
echo "Confirming Client-side truststore...(use password: client_truststore)"
keytool -keystore ${CLIENT_TRUST_STORE} -list

echo
echo '---'
echo

echo "Mutually registered client & server via TrustStores !!!"

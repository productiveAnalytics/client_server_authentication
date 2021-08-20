# SSL mutual authentication for Client and Server using PKCS12 truststore

Note: 
- Prefer open-source PKCS12 format over Java-specific JKS format
- In Java, KeyStore and TrustStore both look same. The difference comes from the functionality
- The KeyStore holds the private key and certificates
- The TrustStore holds the public key/certificate of the of the Authenticator. e.g. to handshake with SSL-enabled Server, the client-side truststore holds the public key/certificate of the Server
- To download server's public SSL certificate:
```
openssl s_client -connect us-east-1-mykafka-cluster.technology:9092 > mykafka_server.crt
```
- To convert public certificate into DER format (prefer over PEM as PEM needs Private Key)
```
openssl x509 -outform der -in mykafka_server.crt -out mykafka_server.der
```
- To import the Server's public certificate in client-side truststore:
```
keytool -import -alias mykafka_cert -keystore mykafka_client_truststore.jks -file mykafka_server.der
```

## Step 1: Create key, certificate and PKCS12 keystore for Server (Use password: server)
```
chmod +x ./create_server_truststore.sh
./create_server_truststore.sh
cd server/ && ls -larth
```

## Step 2: Create key, certificate and PKCS12 keystore for Client (Use password: client)
```
chmod +x ./create_client_truststore.sh
./create_client_truststore.sh
cd client/ && ls -larth
```

## Step 3: Mutually register
### Register client public key in Server's trust store
### Register server public key in Client's trust store
```
chmod +x ./create_truststore_and_mutually_authenticate_server-client.sh
./create_truststore_and_mutually_authenticate_server-client.sh
```

Refer: https://unix.stackexchange.com/questions/347116/how-to-create-keystore-and-truststore-using-self-signed-certificate

# SSL mutual authentication for Client and Server using PKCS12 truststore

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

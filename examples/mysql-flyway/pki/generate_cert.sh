#! /bin/bash

# Generate a local self-signed TLS certificates

set -euo pipefail

CA_COMMON_NAME="myca"
SERVER_COMMON_NAME="mysql"
COUNTRY="my"
ORGANISATION="myorg"
ORGANISATION_UNIT="myou"

CA_PASSWORD="password"
SERVER_PASSWORD="password"

# Remove all files
rm -rf *.pem *.csr *.jks *.p12 *.key

# Generate root CA truststore and certificate
echo "Generating Certificate authority"
keytool -genkeypair \
    -alias root \
    -dname "CN=${CA_COMMON_NAME}, OU=${ORGANISATION_UNIT}, O=${ORGANISATION}, C=${COUNTRY}" \
    -keyalg RSA \
    -keysize 2048 \
    -keystore ca.jks \
    -storepass "${CA_PASSWORD}" \
    -keypass "${CA_PASSWORD}" \
    -validity 3650

# Export root CA certificate to generate server certificate
echo "Exporting Certificate authority"
keytool -exportcert \
    -rfc \
    -keystore \
    ca.jks \
    -alias root \
    -storepass "${CA_PASSWORD}" \
    -file ca.crt

# Change root ca permissions
chmod 0644 ca.crt

# Generate the Server Certificate
echo "Generate Server Certificate"
keytool -genkeypair \
    -alias server \
    -dname "CN=${SERVER_COMMON_NAME}, OU=${ORGANISATION_UNIT}, O=${ORGANISATION}, C=${COUNTRY}" \
    -keyalg RSA \
    -keysize 2048 \
    -keystore server.jks \
    -storepass "${SERVER_PASSWORD}" \
    -keypass "${SERVER_PASSWORD}" \
    -validity 365

# Generate a CSR for the server
echo "Generate a CSR for the server"
keytool -certreq \
    -alias server \
    -keystore server.jks \
    -storepass "${SERVER_PASSWORD}" \
    -file server.csr

# Sign the server CSR using the root CA:
echo "Signing CSR for the server using the root CA"
keytool -gencert \
    -alias root \
    -keystore ca.jks \
    -storepass "${CA_PASSWORD}" \
    -infile server.csr \
    -outfile server.crt \
    -ext ku:c=dig,keyEncipherment \
    -ext san=dns:mysql \
    -rfc

# Import the server certificate and the root into the server keystore:
echo "Importing server certificates into the server keystore"
keytool -importcert -alias root -keystore server.jks -storepass "${SERVER_PASSWORD}" -file ca.crt -trustcacerts -noprompt
keytool -importcert -alias server -keystore server.jks -storepass "${SERVER_PASSWORD}" -file server.crt -noprompt

# Convert server keystore from jks topP12 to allow exporting private keys
echo "Converting jks to p12"
keytool -importkeystore \
    -srckeystore server.jks \
    -destkeystore server.p12 \
    -deststoretype PKCS12 \
    -srcalias server \
    -deststorepass "${SERVER_PASSWORD}" \
    -destkeypass "${SERVER_PASSWORD}" \
    -srcstorepass "${SERVER_PASSWORD}"

# Export server private key from p12 file
echo "Exporting private key from p12 file"
openssl pkcs12 -in server.p12 -nocerts -nodes -out server.key -passin "pass:${SERVER_PASSWORD}"
chmod 0644 server.key

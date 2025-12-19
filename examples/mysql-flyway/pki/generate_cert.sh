#! /bin/bash

# Generate a local self-signed TLS certificates

set -euo pipefail

CA_NAME="mycn"
STATE="mystate"
LOCALE="myloc"
COUNTRY="my"
ORGANISATION="myorg"
ORGANISATION_UNIT="myou"


# Create paths for certificate generation
PKI_PATH="/pki"
SERVER_NAME="mysql"
mkdir -p "${PKI_PATH}"

# Generate CA private key
openssl genrsa -out "${PKI_PATH}/ca.key" 4096

# Generate CA cert signed using CA private key
openssl req -x509 -new -nodes -sha512 \
        -days 3650 \
        -key "${PKI_PATH}/ca.key" \
        -out "${PKI_PATH}/ca.crt" \
        -subj "/CN=${CA_NAME}/C=${COUNTRY}/ST=${STATE}/L=${LOCALE}/O=${ORGANISATION}/OU=${ORGANISATION_UNIT}"

# Generate server private key
openssl genrsa -out "${PKI_PATH}/server.key" 4096

# Generate server certificate signing request (CSR)
openssl req -new \
        -key "${PKI_PATH}/server.key" \
        -out "${PKI_PATH}/server.csr" \
        -subj "/CN=${SERVER_NAME}/C=${COUNTRY}/ST=${STATE}/L=${LOCALE}/O=${ORGANISATION}/OU=${ORGANISATION_UNIT}"

# Generate ext file for subject alternative name (SAN)
tee "${PKI_PATH}/server.ext" <<- EOF
        authorityKeyIdentifier=keyid,issuer"
        basicConstraints=CA:FALSE
        keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
        subjectAltName = @alt_names
        [alt_names]
        DNS.1 = ${SERVER_NAME}
EOF

# Generate server certificate from CSR, signed by CA
openssl x509 -req -CAcreateserial \
        -days 365 \
        -CA "${PKI_PATH}/ca.crt" \
        -CAkey "${PKI_PATH}/ca.key" \
        -in "${PKI_PATH}/server.csr" \
        -out "${PKI_PATH}/server.crt" \
        -extfile "$PKI_PATH/server.ext"

# Set permissions so other containers can read certificates
chmod 0755 -R "${PKI_PATH}"

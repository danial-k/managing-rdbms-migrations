FROM eclipse-temurin

WORKDIR /pki

# Copy and make executable script to generate local self-signed certs
COPY generate_cert.sh /generate_cert.sh
RUN chmod +x /generate_cert.sh

CMD [ "/generate_cert.sh" ]

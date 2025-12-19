# MySQL Flyway example
## Usage
From this directory, run the following:
```shell
docker compose up
```

Note that due to limitations in MySQL Community edition, generation of certificates must be performed manually, hence the pki container.
Self-signed certificates are placed in `./pki/output` and mounted to the database container.

# Managing RDBMS Migrations

## Introduction
Database migrations can be thought of as version control for relational databases.
Most web frameworks provide utilities to provision databases but they are often limited.
This repo provides examples on using [flyway](https://www.red-gate.com/products/flyway/) to manage changes to databases.

### Benefits of using a migration utility
- Separation of application logic from database management
- Decoupling of language/framework from database management
- Separation of DDL permissions (e.g. `CREATE TABLE`) from DML permissions (e.g. `INSERT`)
- Allows management of non-application tables, e.g. sharding
- Simplifies deployment of databases in multiple environment, including locally.
- Sophisticated change management with rollbacks and auditing

### Drawbacks of using a migration utility
- Repeated schema definition in app and SQL migrations
- More complex CI/CD pipelines
- An additional tool to learn

## Examples & Tutorials

Note the following features of Flyway:
- After flyway has run, a table named `flyway_schema_history` showing all successful and failed migrations will be created and populated.
- FLyway [migrations](https://documentation.red-gate.com/flyway/flyway-concepts/migrations) should be named correctly, see naming conventions for [versioned migrations](https://documentation.red-gate.com/flyway/flyway-concepts/migrations/versioned-migrations) and [repeatable migrations](https://documentation.red-gate.com/flyway/flyway-concepts/migrations/repeatable-migrations).
- To ensure a repeatable migration is applied every time flyway is run, add the following to the top of the migration sql file:
  ```sql
  -- ${flyway:timestamp}
  ```

### PostgreSQL + Flyway
Tasks:
- Create a docker compose file with two containers (postgres and flyway)
- Enable the built-in snake-oil certification on the postgres container
- Use Docker environment variables to create a root user that will be used by flyway
- Create an additional application user via the container's startup script.
- Create some flyway migration sql files
- Use the flyway docker compose service to apply the sql migrations to the postgres database

For a completed solution, navigate to the [postgresql-flyway](./examples/postgresql-flyway/) example directory.

### MySQL + Flyway

> [!NOTE]
> Unlike PostgreSQL, MySQL Community does not provide self-signed certificates, these will need to be created manually, for example via a third container.

> [!NOTE]
> Flyway requires a java key store (JKS) to read certificates.

Tasks:
- Create a docker compose file with three containers (mysql, flyway and JDK)
- Create a JDK container to generate a self-signed CA and server certificate
- Mount certificates into a MySQL container
- Create an additional application user via the container's environment variable configuration
- Create some flyway migration sql files
- Use the flyway docker compose service to apply the sql migrations to the MySQL database

For a complete solution, navigate to the [mysql-flyway](./examples/mysql-flyway/) example directory.

# Managing RDBMS Migrations

## Introduction
Database migrations can be thought of as version control for relational databases.
Most web frameworks provide utilities to provision databases but they are often limited.
This repo provides examples on using [flyway](https://www.red-gate.com/products/flyway/) to manage changes to databases.

# Benefits of using a migration utility
- Separation of application logic from database management
- Decoupling of language/framework from database management
- Separation of DDL permissions (e.g. `CREATE TABLE`) from DML permissions (e.g. `INSERT`)
- Allows management of non-application tables, e.g. sharding
- Simplifies deployment of databases in multiple environment, including locally.
- Sophisticated change management with rollbacks and auditing

# Drawbacks of using a migration utility
- Repeated schema definition in app and SQL migrations
- More complex CI/CD pipelines
- An additional tool to learn

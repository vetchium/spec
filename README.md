# Vetchium Database Setup

This directory contains the database schema and a `docker-compose.yml` file to set up the Vetchium global and regional databases.

## Database Schemas

- `global_schema.sql`: Defines the schema for the global database, containing shared, non-sensitive data.
- `regional_schema.sql`: Defines the schema for regional databases, storing operational and PII data for entities homed in that region.

## Docker Compose Setup

The `docker-compose.yml` file sets up two PostgreSQL instances:

- `global_db`: Runs on port `5432` and initializes with `global_schema.sql`.
- `regional_db`: Runs on port `5433` and initializes with `regional_schema.sql`.

### How to run the databases:

1.  Make sure you have Docker and Docker Compose installed.
2.  Navigate to the `spec` directory:
    ```bash
    cd /Users/psankar/vetchium/spec
    ```
3.  Start the databases using Docker Compose:
    ```bash
    docker-compose up -d
    ```

### To connect to the databases:

-   **Global Database:**
    -   Host: `localhost`
    -   Port: `5432`
    -   Database: `vetchium_global`
    -   User: `user`
    -   Password: `password`

-   **Regional Database:**
    -   Host: `localhost`
    -   Port: `5433`
    -   Database: `vetchium_regional`
    -   User: `user`
    -   Password: `password`

### To stop the databases:

```bash
docker-compose down
```

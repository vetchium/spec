# Vetchium Database Setup

This directory contains the database schema and a `docker-compose.yml` file to set up the Vetchium global and regional databases.

## Database Schemas

- `global_schema.sql`: Defines the schema for the global database, containing shared, non-sensitive data.
- `regional_schema.sql`: Defines the schema for regional databases, storing operational and PII data for entities homed in that region.

## Docker Compose Setup

The `docker-compose.yml` file sets up three PostgreSQL instances:

- `global_db`: Runs on port `5432` and initializes with `global_schema.sql`.
- `regional_db_eu_dev`: Runs on port `6001` and initializes with `regional_schema.sql`.
- `regional_db_in_dev`: Runs on port `6002` and initializes with `regional_schema.sql`.

## Data Persistence

The database data is persisted using Docker volumes. This ensures that your data is not lost when the containers are stopped and removed. The following volumes are created:

- `global_db_data`: For the global database.
- `eu_dev_data`: For the EU regional database.
- `in_dev_data`: For the IN regional database.

## Current Status

The Docker Compose setup for the global and regional databases is now functional, and all databases initialize correctly with their respective schemas.

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

-   **EU Regional Database:**
    -   Host: `localhost`
    -   Port: `6001`
    -   Database: `vetchium_regional_eu_dev`
    -   User: `user`
    -   Password: `password`

-   **IN Regional Database:**
    -   Host: `localhost`
    -   Port: `6002`
    -   Database: `vetchium_regional_in_dev`
    -   User: `user`
    -   Password: `password`

### Connecting with psql:

-   **Global Database:**
    ```bash
    psql -h localhost -p 5432 -U user -d vetchium_global
    ```

-   **EU Regional Database:**
    ```bash
    psql -h localhost -p 6001 -U user -d vetchium_regional_eu_dev
    ```

-   **IN Regional Database:**
    ```bash
    psql -h localhost -p 6002 -U user -d vetchium_regional_in_dev
    ```

### To stop the databases:

```bash
docker-compose down
```

### To stop the databases and remove volumes:

```bash
docker-compose down -v
```

[![GitHub release](https://img.shields.io/github/release/sismics/docker-postgresql.svg?style=flat-square)](https://github.com/sismics/docker-backupninja/releases/latest)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## About
Docker image for PostgreSQL

## Usage
- Create a volume for persistent storage:

```
docker volume create --name=postgresql_data
```

- Copy the **docker-compose.yml** and modify it if needed.

- Start the PostgreSQL server:

```
docker-compose create
docker-compose start
```

- Connect to your DB and **change the default password**

Default user is **admin** / **docker**.

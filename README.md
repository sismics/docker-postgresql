# docker-postgresql
Dockerfile for PostgreSQL

## Usage
- Create a volume for persistent storage:

```
docker volume create --name=postgresql_data
```

- Copy the **docker-compose.yml** and modify it if needed.

- Start the PostgreSQL server:

```
docker-compose service create
docker-compose service start
```

- Connect to your DB and **change the default password**

Default user is **admin** / **docker**.

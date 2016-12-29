#!/bin/sh

docker rm -f postgresql
docker run -d -p 5432:5432 --name postgresql --restart=always \
    -v postgresql_data:/data \
    sismics/postgresql:9.6

#/bin/bash

# Create the network
docker network create task1-net

# Create the database
docker run --name postgres-db \
--network task1-net \
-e POSTGRES_PASSWORD=mySuperPassword \
-e POSTGRES_USER=sonar-user \
-e POSTGRES_DB=sonar-db \
-d postgres:latest


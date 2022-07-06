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

# Create the sonarcube
docker run --name sonarqube \
--network=task1-net -p 9000:9000 \
-e SONARQUBE_JDBC_USERNAME=sonar-user \
-e SONARQUBE_JDBC_PASSWORD=mySuperPassword \
-e SONARQUBE_JDBC_URL=jdbc:postgresql://postgres-db/sonar-db sonarqube:latest

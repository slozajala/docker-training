#/bin/bash

sudo sysctl -w vm.max_map_count=262144
sudo systemctl restart docker     

# Create the network
docker network create task1-net

# Create the database
docker run --name postgres-db \
--network task1-net \
-e POSTGRES_PASSWORD=mySuperPassword \
-e POSTGRES_USER=sonar-user \
-e POSTGRES_DB=sonar-db \
-e PGDATA=/var/lib/postgresql/data/pgdata \
-v $(pwd)/store/database:/var/lib/postgresql/data \
-d postgres:latest

# Create the sonarcube
docker run --name sonarqube \
--network=task1-net -p 9000:9000 \
-e SONARQUBE_JDBC_USERNAME=sonar-user \
-e SONARQUBE_JDBC_PASSWORD=mySuperPassword \
-e SONARQUBE_JDBC_URL=jdbc:postgresql://postgres-db/sonar-db \
-v $(pwd)/store/sonarqube/data:/opt/sonarqube/data \
-v $(pwd)/store/sonarqube/logs:/opt/sonarqube/logs \
-v $(pwd)/store/sonarqube/extensions:/opt/sonarqube/extensions \
-d sonarqube:latest

# Jenkins
docker run --name jenkins \
--network=task1-net -p 9001:8080 \
-v $(pwd)/store/jenkins:/var/jenkins_home \
-d jenkins/jenkins:lts-jdk11

# Nexus
sudo chown -R 200 $(pwd)/store/nexus/data
docker run --name nexus \
--network=task1-net -p 9002:8081 \
-v $(pwd)/store/nexus/data:/nexus-data \
-d sonatype/nexus3

# portainer
docker run --name portainer \
--network=task1-net -p 9003:9000 -p 9443:9443 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $(pwd)/store/portainer/data:/data \
-d portainer/portainer-ce:2.9.3

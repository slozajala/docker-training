# docker-training

Homework 1 - Docker Containers

Instructions
You have to mount the following stack by applying all you learnt about Docker so far:
1. PostgreSQL
- Start a Postgres container up taking the official image from Docker Hub:
https://hub.docker.com/_/postgres
- This container MUST NOT EXPOSE OR PUBLISH ANY PORTS.
- Set the Environment Variables according to the documentation in order
to create an empty Database, define user and password basically.
- The Database created within the container will store all the data from
Sonarqube container.
2. Sonarqube Community Edition
- Start a Sonarqube Community Edition container up taking the official
image from Docker Hub: https://hub.docker.com/_/sonarqube
- This container has to publish a port in order to access the Web UI.
- Set the Environment Variables properly according to the documentation
in order to connect it to the Postgres database created.
- IMPORTANT: the DB connection string MUST NOT CONTAIN AN IP, but
rather, the Postgres container name instead.

3. Jenkins
- Start a Jenkins container up taking the official image from Docker Hub:
https://hub.docker.com/r/jenkins/jenkins

4. Sonatype Nexus 3
- Start a Nexus 3 container up taking the official image from Docker Hub:
https://hub.docker.com/r/sonatype/nexus3

5. Portainer
- Start a Portainer container up taking the official image from Docker Hub:
https://hub.docker.com/r/portainer/portainer

Mandatory
- All the containers must have their own volumes respectively (according their
documentation).
- You have to assign a name to each container.
- All the containers have to be run in a detached way.
- Create an User-Defined Network Bridge and all the containers must be
attached to that network.
- Create a bash script file, for example: myhomework.sh

- In that bash script, register each Docker command you have used to perform
this homework successfully.
- Version that bash script file in your Git Repo.
- Send the link of your Git Repo that contains the bash script to the trainer by
email.

To Consider:
- https://docs.sonarqube.org/latest/setup/install-server/#header-4
- Print the container logs with the following command (will help you to debug):
docker logs CONTAINER_NAME
- ERROR: Max virtual memory areas vm.max_map_count 65530 is too low,
increase to at least
In case you get that error when starting up Sonarqube::
- Execute this command:
sudo sysctl -w vm.max_map_count=262144
- Restart the Docker Service:
sudo systemctl restart docker
- Try to start up the Sonarqube container again..

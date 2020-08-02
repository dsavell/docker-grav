#!/bin/bash

export DOCKER_ID_USER=''
GRAV_VERSION=$(curl -sX GET "https://api.github.com/repos/getgrav/grav/releases/latest" | jq -r .tag_name)
export GRAV_VERSION

## Build Grav Core
docker build -t grav -f Dockerfile.gravcore .
docker tag grav ${DOCKER_ID_USER}/grav:latest
docker tag grav ${DOCKER_ID_USER}/grav:core
docker tag grav ${DOCKER_ID_USER}/grav:"${GRAV_VERSION}"
docker tag grav ${DOCKER_ID_USER}/grav:core-"${GRAV_VERSION}"
docker push ${DOCKER_ID_USER}/grav:latest
docker push ${DOCKER_ID_USER}/grav:core
docker push ${DOCKER_ID_USER}/grav:"${GRAV_VERSION}"
docker push ${DOCKER_ID_USER}/grav:core-"${GRAV_VERSION}"

## Build Grav Core Admin Plugin
docker build -t grav:admin -f Dockerfile.gravcoreadmin .
docker tag grav:admin ${DOCKER_ID_USER}/grav:admin
docker tag grav:admin ${DOCKER_ID_USER}/grav:admin-"${GRAV_VERSION}"
docker push ${DOCKER_ID_USER}/grav:admin
docker push ${DOCKER_ID_USER}/grav:admin"-${GRAV_VERSION}"

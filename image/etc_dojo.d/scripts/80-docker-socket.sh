#!/usr/bin/env bash

set -e

## https://vitorbaptista.com/how-to-access-hosts-docker-socket-without-root

DOCKER_SOCKET=/var/run/docker.sock
DOCKER_GROUP=docker
REGULAR_USER=dojo

if [ -S ${DOCKER_SOCKET} ]; then
    DOCKER_GID=$(stat -c '%g' ${DOCKER_SOCKET})
    groupadd -for -g "${DOCKER_GID}" ${DOCKER_GROUP}
    usermod -aG "${DOCKER_GROUP}" ${REGULAR_USER}
fi
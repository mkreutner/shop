#!/bin/bash

DOCKER_COMPOSE_CMD="$(which docker) compose"

${DOCKER_COMPOSE_CMD} down --volumes

sudo rm -rf src/api/* src/bo/* src/shop/*
sudo rm -rf src/api/.* src/bo/.* src/shop/.*

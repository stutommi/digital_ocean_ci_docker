#!/bin/sh

set -e # Stop script from running if there are any errors

IMAGE="stutommi/do-test"                             # Docker image
GIT_VERSION=$(git describe --always --abbrev --tags --long) # Git hash and tags

# Build and tag image
yarn build
docker build -t ${IMAGE}:${GIT_VERSION} .
docker tag ${IMAGE}:${GIT_VERSION} ${IMAGE}:latest

# Log in to Docker Hub and push
echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USERNAME}" --password-stdin
docker push ${IMAGE}:${GIT_VERSION}
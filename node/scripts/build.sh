#!/bin/sh

readonly GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

docker build --no-cache -t nodeserverhttp2talk -f ${GIT_ROOT_DIR}/node/docker/Dockerfile .
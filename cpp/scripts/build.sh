#!/bin/bash

readonly GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

docker build --no-cache -t cppserverhttp2talk -f ${GIT_ROOT_DIR}/cpp/docker/Dockerfile .
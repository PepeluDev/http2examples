#!/bin/bash

readonly GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

docker build -t cppserverbase -f ${GIT_ROOT_DIR}/cpp/docker/base/Dockerfile .
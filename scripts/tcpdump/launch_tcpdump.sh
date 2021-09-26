#!/bin/sh

readonly GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

docker run --rm --net=http2-network -v ${GIT_ROOT_DIR}/scripts/tcpdump:/tcpdump kaazing/tcpdump

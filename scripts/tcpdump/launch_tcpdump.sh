#!/bin/sh

readonly GIT_ROOT_DIR=$(git rev-parse --show-toplevel)

docker run --rm --net=container:http2examples_myhttp2client_1 -v ${GIT_ROOT_DIR}/scripts/tcpdump:/tcpdump kaazing/tcpdump

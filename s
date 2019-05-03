#!/bin/sh
exec docker run -it --rm -v "$PWD":/workspace \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e USER="$USER" -u $(id -u):$(id -g) \
    --entrypoint=bash \
    vicaya/vimdev "$@"

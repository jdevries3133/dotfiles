#!/bin/bash

set -euxo pipefail

if [ -z "$(docker image ls | grep claude)" ]
then
    file="$(mktemp)"
    cat <<'EOF' > $file
FROM node:latest
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y curl jq python3
RUN npm install -g @anthropic-ai/claude-code
RUN adduser jack && mkdir -p /home/jack && chown -R jack:jack /home/jack
USER jack
WORKDIR /home/jack/workdir
ENTRYPOINT claude
EOF
    docker build -t claude -f $file .
fi
docker volume create claude-home
docker run \
    -it \
    --env DISABLE_AUTOUPDATER=1 \
    -v claude-home:/home/jack \
    -v $(pwd):/home/jack/workdir \
    claude

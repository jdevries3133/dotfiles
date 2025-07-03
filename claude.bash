#!/bin/bash

set -euxo pipefail

file="$(mktemp)"
cat <<'EOF' > $file
FROM node:latest
RUN npm install -g @anthropic-ai/claude-code
RUN adduser jack && mkdir -p /home/jack && chown -R jack:jack /home/jack
USER jack
WORKDIR /home/jack/workdir
ENTRYPOINT claude
EOF
docker build -t claude -f $file .
docker volume create claude-home
docker run \
    -it \
    --env DISABLE_AUTOUPDATER=1 \
    -v claude-home:/home/jack \
    -v $(pwd):/home/jack/workdir \
    claude

#!/bin/bash

# https://github.com/baklai/proxy/blob/main/README.md

PROXY_BASE="${PROXY_BASE:-$(pwd)}"
[[ -d "$PROXY_BASE" ]] || mkdir -p "$PROXY_BASE" || { echo "Couldn't create storage directory: $PROXY_BASE"; exit 1; }

# Note: 
docker run -d \
    --name proxy \
    -p 8118:8118 \
    -e TZ="America/Chicago" \
    -v "${PROXY_BASE}/ptproxy/privoxy:/etc/privoxy" \
    -v "${PROXY_BASE}/ptproxy/tor:/etc/tor" \
    baklai/proxy:latest

printf 'Starting up proxy container '
for i in $(seq 1 20); do
    if [ "$(docker inspect -f "{{.State.Health.Status}}" proxy)" == "healthy" ] ; then
        printf ' OK'
        exit 0
    else
        sleep 3
        printf '.'
    fi

    if [ $i -eq 20 ] ; then
        echo -e "\nTimed out waiting for proxy start, consult your container logs for more info (\`docker logs proxy\`)"
        exit 1
    fi
done;
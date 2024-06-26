# Docker: Tor Proxy

![Docker Tor Proxy](https://raw.githubusercontent.com/baklai/docker-tor/main/preview.png)

A fast, minimalist proxy system using [Tor](https://www.torproject.org) for unrestricted internet browsing.

**About Tor**

The goal of onion routing was to have a way to use the internet with as much privacy as possible, and the idea was to route traffic through multiple servers and encrypt it each step of the way. This is still a simple explanation for how Tor works today.

## Quick Start

The quickest way to get started is using bash script.

```bash
# Linux
wget -O tor-init.sh https://raw.githubusercontent.com/baklai/docker-tor/main/tor-init.sh
chmod +x tor-init.sh
./tor-init.sh

# Windows
wget -O tor-init.ps1 https://raw.githubusercontent.com/baklai/docker-tor/main/tor-init.ps1
./tor-init.ps1
```

Access your proxy at `http://localhost:9050`.

## Started is docker compose

The quickest way to get started is using [docker compose](https://docs.docker.com/compose/).

Copy default docker compose file

```bash
# Copy default docker compose file
wget -O compose.yaml https://raw.githubusercontent.com/baklai/docker-tor/main/compose.yaml
```

or create custom docker compose file `compose.yaml`

```bash
# Create custom docker compose file

services:
  tor:
    image: baklai/tor:latest
    ports:
      - '9050:9050'
    volumes:
      - ./etc/tor:/etc/tor
```

Run docker compose to build and start proxy

```bash
# When you're ready, start application by running
docker compose up -d --build

# Since this application was started using Docker Compose, it's easy to tear it all down when you're done.
docker compose down --volumes

# Look at the logs
docker compose logs -f
```

Access your proxy at `http://localhost:8118`.

## Started is locally

```bash
# Launch image locally
docker run -d --name tor -p 9050:9050 baklai/tor:latest
```

Access your proxy at `http://localhost:9050`.

### Parameters

| Parameter               | Description                 |
| ----------------------- | --------------------------- |
| `-p 9050:9050`          | Expose the proxy service    |
| `-v ./etc/tor:/etc/tor` | Main tor configuration file |

## Testing/Debugging

To debug the container:

```bash
docker logs -f tor
```

To get an interactive shell:

```bash
docker exec -it tor /bin/bash
```

Status service an interactive shell

```bash
docker exec -it tor service tor status
```

## Build and Deploying application to the local or cloud

First, build docker image, e.g.:

```bash
docker build -t baklai/tor .
```

Then, push it to your registry, e.g.

```bash
docker push baklai/tor
```

If your cloud uses a different CPU architecture than your development
machine (e.g., you are on a Mac M1 and your cloud provider is amd64),
you'll want to build the image for that platform, e.g.:

```bash
# Make sure you have buildx installed. If it is not installed, install it as follows
docker buildx install

# Build and switch to buildx builder
docker buildx create --name multibuilder --use
```

```bash
# Use Docker registry
docker login
```

```bash
# Uploading an image to local Docker
docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t baklai/tor --load .

# Uploading an image to the Docker registry
docker buildx build --platform linux/amd64,linux/arm/v7,linux/arm64/v8,linux/ppc64le,linux/s390x -t baklai/tor --push .
```

Consult Docker's [getting started](https://docs.docker.com/go/get-started-sharing/)
docs for more detail on building and pushing.

## License

[MIT](LICENSE)

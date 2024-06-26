# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/go/dockerfile-reference/

FROM debian:latest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y tor && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

RUN cp /etc/tor/torrc /etc/tor/torrc.default
RUN echo "SocksPort 9050 # Default: Bind to localhost:9050 for local connections." > /etc/tor/torrc

EXPOSE 9050

CMD ["sh", "-c", "tor --no-daemon /etc/tor/torrc"]

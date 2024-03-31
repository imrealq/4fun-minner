FROM debian:bookworm-slim

RUN apt update

RUN apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev -y

COPY xmrig /xmrig

RUN mkdir -p /xmrig/build

RUN cd /xmrig/build && cmake .. && make

WORKDIR /xmrig/build
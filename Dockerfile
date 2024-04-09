FROM debian:bookworm-slim

RUN apt update

RUN apt install build-essential cmake libuv1-dev libssl-dev libhwloc-dev git -y

# install xmrig
WORKDIR /

RUN git clone --depth 1 https://github.com/xmrig/xmrig.git xmrig

RUN mkdir -p /build

WORKDIR /build

RUN cmake /xmrig && make

RUN rm -rf /xmrig

COPY config.json .

CMD ["./xmrig", "-c", "config.json"]
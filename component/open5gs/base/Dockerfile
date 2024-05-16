FROM ubuntu:focal-20240427 as builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
    meson mongodb curl gnupg ninja-build build-essential flex bison git cmake ca-certificates \
    python3-pip python3-setuptools python3-wheel \
    libsctp-dev libgnutls28-dev libgcrypt-dev libssl-dev libidn11-dev libmongoc-dev libbson-dev \
    libyaml-dev libmicrohttpd-dev libcurl4-gnutls-dev libnghttp2-dev libtins-dev libidn11-dev libtalloc-dev

RUN git clone --recursive --depth=1 https://github.com/open5gs/open5gs -b v2.7.1 && cd open5gs && \
    meson build --prefix=`pwd`/install && \
    ninja -C build && cd build && ninja install && \
    mkdir -p /open5gs/install/include

FROM node:20.12.2-buster as builder_webui

RUN git clone --recursive --depth=1 https://github.com/open5gs/open5gs -b v2.7.1 && cd open5gs && npm ci

FROM ubuntu:focal-20240427

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y --no-install-recommends \
    curl ca-certificates netbase ifupdown net-tools iputils-ping iptables iperf mongodb-clients gnupg \
    python3-setuptools python3-wheel python3-pip \
    libssl-dev libyaml-dev libmicrohttpd-dev libmongoc-dev libsctp-dev libcurl4-gnutls-dev libtins-dev libidn11-dev libtalloc-dev && \
    apt autoremove -y && apt autoclean

RUN pip3 install click

RUN update-ca-certificates

COPY --from=builder /open5gs/install/bin /open5gs/install/bin
COPY --from=builder /open5gs/install/etc /open5gs/install/etc
COPY --from=builder /open5gs/install/include /open5gs/install/include
COPY --from=builder /open5gs/install/lib /open5gs/install/lib
COPY --from=builder /open5gs/misc/db /open5gs/misc/db

# Set the working directory to open5gs
WORKDIR /open5gs

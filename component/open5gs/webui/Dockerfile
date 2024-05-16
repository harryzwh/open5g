FROM node:20.12.2-buster as builder

RUN git clone --recursive --depth=1 https://github.com/open5gs/open5gs -b v2.7.1 && cd open5gs/webui && npm ci

FROM node:20.12.2-slim

COPY --from=builder /open5gs/webui /open5gs/webui
COPY ./config /mnt/webui

WORKDIR /open5gs/webui

ENTRYPOINT ["/bin/bash", "/mnt/webui/startup.sh"]
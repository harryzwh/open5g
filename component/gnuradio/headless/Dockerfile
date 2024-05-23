FROM ubuntu:jammy-20240427

#gnuradio setup
RUN apt update && apt install -y --no-install-recommends software-properties-common gpg-agent

RUN add-apt-repository -y ppa:gnuradio/gnuradio-releases-3.9

RUN apt update && apt install -y --no-install-recommends gnuradio 

COPY ./config /config

ENTRYPOINT [ "python3", "-u", "/config/channel.py" ]
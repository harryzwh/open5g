FROM lscr.io/linuxserver/webtop:ubuntu-xfce-version-fc857b2e

#gnuradio setup
RUN apt update

# else it will output an error about Gtk namespace not found
RUN apt install -y gir1.2-gtk-3.0 software-properties-common

RUN add-apt-repository -y ppa:gnuradio/gnuradio-releases-3.9

RUN apt update && apt install -y gnuradio gnuradio-dev cmake git libboost-all-dev libcppunit-dev liblog4cpp5-dev python3-pygccxml pybind11-dev liborc-dev libx11-dev

ENV PYTHONPATH "${PYTHONPATH}:/usr/local/lib/python3/dist-packages"

RUN mkdir /script && chmod 0777 /script

COPY ./config /script
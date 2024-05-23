FROM ubuntu:jammy-20240427

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt -y install cmake make gcc g++ pkg-config libfftw3-dev libmbedtls-dev libsctp-dev libyaml-cpp-dev libgtest-dev \
    libzmq3-dev software-properties-common pkg-config net-tools iputils-ping git

RUN add-apt-repository ppa:ettusresearch/uhd && \
    apt update && apt -y install libuhd-dev uhd-host && \
    uhd_images_downloader

ENV UHD_IMAGES_DIR=/usr/share/uhd/images/

RUN git clone --depth=1 -b OPS_KPM https://github.com/harryzwh/srsRAN_Project.git && cd srsRAN_Project && \
    mkdir build && cd build && \
    cmake ../ -DENABLE_EXPORT=ON -DENABLE_ZEROMQ=ON && make -j`nproc` && make install && ldconfig

COPY ./config /mnt/config

ENTRYPOINT [ "/bin/bash", "/mnt/config/startup.sh" ]

#78238fd15e4cd82a6324d6dbbb612ac5584b13ea
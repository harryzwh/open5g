FROM gcc:10.5.0-bullseye as builder

ENV DEBIAN_FRONTEND=noninteractive

COPY ./sources.list /etc/apt/sources.list

RUN apt update && apt install -y swig libsctp-dev python3 cmake-curses-gui python3-dev pkg-config libconfig-dev libconfig++-dev

RUN git clone --depth=1 -b br-flexric https://gitlab.eurecom.fr/mosaic5g/flexric.git && cd flexric && \
    mkdir build && cd build && cmake -DKPM_VERSION=KPM_V3 -DXAPP_DB=NONE_XAPP ../ && make && make install

FROM ubuntu:jammy-20240427

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y libsctp-dev libconfig-dev libconfig++-dev

COPY --from=builder /usr/local/lib/flexric /usr/local/lib/flexric
COPY --from=builder /usr/local/bin/flexric/xApp/c/xapp_hw /usr/local/bin/flexric/xApp/c/xapp_hw
COPY --from=builder /usr/local/bin/flexric/xApp/c/xapp_all_moni /usr/local/bin/flexric/xApp/c/xapp_all_moni
COPY --from=builder /usr/local/bin/flexric/xApp/c/xapp_cust_moni /usr/local/bin/flexric/xApp/c/xapp_cust_moni
COPY --from=builder /usr/local/bin/flexric/xApp/c/xapp_oran_moni /usr/local/bin/flexric/xApp/c/xapp_oran_moni
COPY --from=builder /usr/local/bin/flexric/xApp/c/xapp_slice_moni_ctrl /usr/local/bin/flexric/xApp/c/xapp_slice_moni_ctrl

COPY ./config/xapp_mon_e2sm_kpm.conf /usr/local/etc/flexric/xapp_mon_e2sm_kpm.conf

WORKDIR /usr/local/bin/flexric/xApp

CMD ["./c/xapp_oran_moni", "-c", "/usr/local/etc/flexric/xapp_mon_e2sm_kpm.conf"]



    # -- Install configuration: "Debug"
    # -- Installing: /usr/local/lib/flexric/libmac_sm.so
    # -- Installing: /usr/local/lib/flexric/librlc_sm.so
    # -- Installing: /usr/local/lib/flexric/libpdcp_sm.so
    # -- Installing: /usr/local/lib/flexric/libslice_sm.so
    # -- Installing: /usr/local/lib/flexric/libtc_sm.so
    # -- Installing: /usr/local/lib/flexric/libgtp_sm.so
    # -- Installing: /usr/local/lib/flexric/libkpm_sm.so
    # -- Installing: /usr/local/lib/flexric/librc_sm.so
    # -- Installing: /usr/local/etc/flexric/e2agent.conf
    # -- Installing: /usr/local/etc/flexric/e2proxyagent.conf
    # -- Installing: /usr/local/etc/flexric/ric.conf
    # -- Installing: /usr/local/etc/flexric/xapp_all_sm.conf
    # -- Installing: /usr/local/etc/flexric/xapp_cust_sm.conf
    # -- Installing: /usr/local/etc/flexric/xapp_oran_sm.conf
    # -- Installing: /usr/local/bin/flexric/ric/nearRT-RIC
    # -- Installing: /usr/local/bin/flexric/e2agent/emu_agent_gnb
    # -- Installing: /usr/local/bin/flexric/e2agent/emu_agent_gnb_cu
    # -- Installing: /usr/local/bin/flexric/e2agent/emu_agent_gnb_du
    # -- Installing: /usr/local/bin/flexric/e2agent/emu_agent_enb
    # -- Installing: /usr/local/bin/flexric/xApp/c/xapp_hw
    # -- Installing: /usr/local/bin/flexric/xApp/c/xapp_all_moni
    # -- Installing: /usr/local/bin/flexric/xApp/c/xapp_cust_moni
    # -- Installing: /usr/local/bin/flexric/xApp/c/xapp_oran_moni
    # -- Installing: /usr/local/bin/flexric/xApp/c/xapp_slice_moni_ctrl
    
FROM grafana/grafana:10.4.2-ubuntu

COPY ./config/prometheus_open5gs.yml /etc/grafana/provisioning/datasources
COPY ./config/open5gs_dashboard.yml /etc/grafana/provisioning/dashboards
RUN mkdir -p /var/lib/grafana/dashboards
COPY ./config/open5gs_dashboard.json /var/lib/grafana/dashboards

WORKDIR /usr/share/grafana

ENTRYPOINT [ "./bin/grafana", "server" ]

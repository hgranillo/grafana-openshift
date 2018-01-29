FROM debian:jessie

ENV GRAFANA_VERSION=4.6.3

RUN useradd -u 103000 -M -r grafana

RUN apt-get update && \
    apt-get -y --no-install-recommends install libfontconfig curl ca-certificates && \
    apt-get clean && \
    curl https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${GRAFANA_VERSION}_amd64.deb > /tmp/grafana.deb && \
    dpkg -i /tmp/grafana.deb && \
    rm /tmp/grafana.deb && \
    curl -L https://github.com/tianon/gosu/releases/download/1.10/gosu-amd64 > /usr/sbin/gosu && \
    chmod +x /usr/sbin/gosu && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

COPY ./scripts/fix-permissions /fix-permissions

COPY ./run.sh /run.sh

RUN /fix-permissions /var/log/grafana && \
    /fix-permissions /usr/share/grafana && \
    /fix-permissions /usr/sbin/grafana-server && \
    /fix-permissions /etc/grafana && \
    chmod +x /run.sh

VOLUME ["/var/lib/grafana", "/var/log/grafana", "/etc/grafana"]

EXPOSE 3000

USER 103000

ENTRYPOINT ["/run.sh"]

FROM tutum/nginx
MAINTAINER Feng Honglin <hfeng@tutum.co>

ENV GRAFANA_VERSION 1.9.1

RUN apt-get update && \
    apt-get install -y wget pwgen apache2-utils && \
    wget http://grafanarel.s3.amazonaws.com/grafana-${GRAFANA_VERSION}.tar.gz -O grafana.tar.gz && \
    tar zxf grafana.tar.gz && \
    rm grafana.tar.gz && \
    rm -rf app && \
    mv grafana-${GRAFANA_VERSION} app && \
    apt-get autoremove -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD config.js /app/config.js
ADD default /etc/nginx/sites-enabled/default

# Environment variables for HTTP AUTH
ENV HTTP_USER admin
ENV HTTP_PASS **Random**

ENV INFLUXDB_PROTO http
ENV INFLUXDB_HOST **ChangeMe**
ENV INFLUXDB_PORT 8086
ENV INFLUXDB_NAME **ChangeMe**
ENV INFLUXDB_USER root
ENV INFLUXDB_PASS root
ENV INFLUXDB_IS_GRAFANADB false

ENV ELASTICSEARCH_PROTO http
ENV ELASTICSEARCH_HOST **None**
ENV ELASTICSEARCH_PORT 9200
ENV ELASTICSEARCH_USER **None**
ENV ELASTICSEARCH_PASS **None**


ADD run.sh /run.sh
ADD set_influx_db.sh /set_influx_db.sh
ADD set_basic_auth.sh /set_basic_auth.sh
ADD set_elasticsearch.sh /set_elasticsearch.sh
RUN chmod +x /*.sh

CMD ["/run.sh"]

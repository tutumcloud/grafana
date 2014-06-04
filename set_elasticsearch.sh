#!/bin/bash

set -e

if [ -f /.elasticsearch_configured ]; then
    echo "Elasticsearch has been configured!"
    exit 0
fi

if [ -n "${ELASTICSEARCH_1_PORT_9200_TCP_ADDR}" -a -n "${ELASTICSEARCH_1_PORT_9200_TCP_PORT}" ]; then
    echo "=> Found Elasticsearch settings."
    echo "=> Set Elasticsearch url to \"http://${ELASTICSEARCH_1_PORT_9200_TCP_ADDR}:${ELASTICSEARCH_1_PORT_9200_TCP_PORT}\"."
    sed -i "s#.*elasticsearch.*#elasticsearch:\"http://${ELASTICSEARCH_1_PORT_9200_TCP_ADDR}:${ELASTICSEARCH_1_PORT_9200_TCP_PORT}\",#g"  /app/config.js
    echo "=> Done!"
else
    echo "=> Either address or port of Elasitsearch is not set or empty."
    echo "=> Skip setting Elasticsearch."
fi

touch /.elasticsearch_configured

#!/bin/bash

set -e

if [ -f /.elasticsearch_configured ]; then
    echo "=> Elasticsearch has been configured!"
    exit 0
fi

if [ -n "${ELASTICSEARCH_HOST}" ] && [ -n "${ELASTICSEARCH_PORT}" ]; then
    echo "=> Found Elasticsearch settings."
    echo "=> Set Elasticsearch url to \"http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}\"."
    sed -i "s#.*elasticsearch.*#elasticsearch:\"http://${ELASTICSEARCH_HOST}:${ELASTICSEARCH_PORT}\",#g"  /app/config.js
    echo "=> Done!"
else
    echo "=> Either address or port of Elasticsearch is not set or empty."
    echo "=> Skip setting Elasticsearch."
fi

touch /.elasticsearch_configured

#!/bin/bash
set -e

if [ -f /.influx_db_configured ]; then
    echo "=> InfluxDB has been configured!"
    exit 0
fi

ADDR=''
PORT=''
DB_NAME=''
USER=''
PASS=''

if [ -n "${INFLUXDB_PORT_8086_TCP_ADDR}" ]; then
    ADDR="${INFLUXDB_PORT_8086_TCP_ADDR}"
else
    echo "No address of InfluxDB is specified"
    exit 1
fi


if [ -n "${INFLUXDB_PORT_8086_TCP_PORT}" ]; then
    PORT="${INFLUXDB_PORT_8086_TCP_PORT}"
else
    echo "No port number of InfluxDB is specified"
    exit 1
fi

DB_NAME="${INFLUXDB_DB_NAME}"
USER="${INFLUXDB_USER}"

if [ -z ${INFLUXDB_PASS} ]; then
    if [ -n ${INFLUXDB_INIT_PWD} ]; then
        PASS=${INFLUXDB_INIT_PWD}
    fi
else
    PASS="${INFLUXDB_PASS}"
fi
echo "=> Configuring InfluxDB"
sed -i -e "s/<--ADDR->/${ADDR}/g" -e "s/<--PORT-->/${PORT}/g" -e "s/<--DB_NAME-->/${DB_NAME}/g" -e "s/<--USER-->/${USER}/g" -e "s/<--PASS-->/${PASS}/g" /app/config.js
touch /.influx_db_configured
echo "=> InfluxDB has been configured as follows:"
echo "   InfluxDB ADDRESS:  ${ADDR}"
echo "   InfluxDB PORT:     ${PORT}"
echo "   InfluxDB DB NAME:  ${DB_NAME}"
echo "   InfluxDB USERNAME: ${USER}"
echo "   InfluxDB PASSWORD: ${PASS}"
echo "   ** Please check your environment variables if you find something is misconfigured. **"
echo "=> Done!"

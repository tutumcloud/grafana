#!/bin/bash

set -e


if [ ! -f /.influx_db_configured ]; then
    /set_influx_db.sh
fi

/usr/sbin/nginx

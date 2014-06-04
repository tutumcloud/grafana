#!/bin/bash

set -e

if [ ! -f /.basic_auth_configured ]; then
    /set_basic_auth.sh
fi

if [ ! -f /.influx_db_configured ]; then
    /set_influx_db.sh
fi

echo "=> Starting and running Nginx..."
/usr/sbin/nginx

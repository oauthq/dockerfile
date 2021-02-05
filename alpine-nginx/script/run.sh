#!/bin/bash
#ensure www-data user exists
set -x \
    && adduser -u 82 -D -S -G www-data www-data
mkdir -p /home
mkdir -p /www
chown www-data.www-data /home -R

#!/bin/bash
#ensure www-data user exists
set -x \
    && addgroup -g 82 -S www-data \
    && adduser -u 82 -D -S -G www-data www-data
mkdir -p /home
chown www-data.www-data /home -R

#!/bin/bash
#ensure www-data user exists
set -x && addgroup -g 82 -S www-data
adduser -u 82 -D -S -G www-data www-data
mkdir -p /home
mkdir -p /www
chown www-data.www-data /home -R
chown www-data.www-data /www -R

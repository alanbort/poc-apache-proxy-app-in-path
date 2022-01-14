#!/bin/bash

set -e

echo "Starting PHP FPM Service"
service php7.4-fpm start
echo "Starting Apache Service"
apache2ctl -D FOREGROUND
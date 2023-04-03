#!/bin/sh
printenv | grep -v "no_proxy" >> /etc/environment
echo "CA MARCHE POGGERS"
cron -f
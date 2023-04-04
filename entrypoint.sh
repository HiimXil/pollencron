#!/bin/sh
printenv | grep -v "no_proxy" >> /etc/environment
timedatectl set-timezone "$TZ"
touch /etc/cron.d/pollencron
echo "$CRON /app/script.sh >> /app/log 2>&1" > /etc/cron.d/pollencron
chmod 0644 /etc/cron.d/pollencron
crontab /etc/cron.d/pollencron
echo "CA MARCHE POGGERS"
cron -f
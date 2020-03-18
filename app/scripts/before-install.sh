#!/bin/bash

# Wait to have cfn-init finish
while [ ! -f /usr/local/etc/cfn-finish ]
do
    sleep 2
done

if [ -f /var/run/app.pid ];
then
  pkill -F /var/run/app.pid
fi

if [ -f /srv/web/sites/default/settings.php ]
then
  cp /srv/web/sites/default/settings.php /usr/local/src/settings.php
fi

rm -rf /srv
mkdir -p /srv/logs

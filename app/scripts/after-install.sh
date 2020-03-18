#!/bin/bash

cd /srv

if [ -f /usr/local/src/settings.php ]
then
  cp /usr/local/src/settings.php /srv/web/sites/default/settings.php
fi

cp resources/docker/site.conf /etc/nginx/sites-available/default
cfnStatus=$(cat /usr/local/etc/cfn-finish)

if [[ "$cfnStatus" == "ready" ]]; then
  HOME=/root make install
  echo "installed" > /usr/local/etc/cfn-finish
fi

HOME=/root make migrate
HOME=/root make status

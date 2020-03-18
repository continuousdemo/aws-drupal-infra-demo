#!/bin/bash

cd /srv

cp resources/docker/site.conf /etc/nginx/sites-available/default
cfnStatus=$(cat /usr/local/etc/cfn-finish)

if [[ "$cfnStatus" == "ready" ]]; then
  HOME=/root make install
  echo "installed" > /usr/local/etc/cfn-finish
fi

HOME=/root make migrate
HOME=/root make status

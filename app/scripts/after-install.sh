#!/bin/bash

cd /srv

cp resources/docker/site.conf /etc/nginx/sites-available/default
cfnStatus=$(cat /usr/local/etc/cfn-finish)

if [[ "$cfnStatus" == "ready" ]]; then
  make install
  echo "installed" > /usr/local/etc/cfn-finish
fi

make migrate
make status

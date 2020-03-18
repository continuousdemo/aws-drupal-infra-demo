#!/bin/bash

cd /srv

cfnStatus=$(cat /usr/local/etc/cfn-finish)

if [[ "$cfnStatus" == "ready" ]]; then
  make install
  echo "installed" > /usr/local/etc/cfn-finish
fi

make migrate
make status

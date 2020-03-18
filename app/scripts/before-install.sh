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

rm -rf /var/app
mkdir /var/app

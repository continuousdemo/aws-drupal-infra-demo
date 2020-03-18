#!/bin/bash

ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
php -S $ip:80 /var/app/src/app.php &> /dev/null &disown
echo $! > /var/run/app.pid

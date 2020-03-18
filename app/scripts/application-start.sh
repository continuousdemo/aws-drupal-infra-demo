#!/bin/bash

ip=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

service nginx restart
service php7.2-fpm restart

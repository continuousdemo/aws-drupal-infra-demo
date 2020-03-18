#!/bin/bash

ls -lh
cd /var/app/

make install
make migrate
make status

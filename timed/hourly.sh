#!/bin/sh

cd /home/BOXIK
free >> cron.h.log 2>&1
sync
echo 3 > /proc/sys/vm/drop_caches 
free >> cron.h.log 2>&1

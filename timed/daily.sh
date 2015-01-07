#!/bin/sh

cd /home/BOXIK
killall tcpdump
./hourly.sh
nohup tcpdump -w `date --rfc-3339=date`.log -i any -tt -e >dump.out 2>&1


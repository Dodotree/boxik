#!/bin/sh
cd /home/olgat/boxik/timed
sh ./hourly.sh
cd /home/BOXIK
killall tcpdump
#nohup whereis tcpdump >cron.d.log
nohup /usr/sbin/tcpdump -w `date --rfc-3339=date`.log -i any -tt -e >cron.d.log 2>&1&

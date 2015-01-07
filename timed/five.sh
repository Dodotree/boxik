#!/bin/sh

cd /home/olgat/boxik/timed/
./processes.pl >> ../logs/processes
./memory.pl >> ../logs/memory
./load.pl >> ../logs/load
./temperature.pl >> ../logs/temperature
./ports.pl >> ../logs/ports
./packets.pl >> ../logs/packets
